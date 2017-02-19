require "digest/md5"
require 'evernote-thrift'

module EvernoteApi
  NOTE_TITLE = 'Grocery List'
  NOTE_NOTEBOOK = 'Shopping List'
  EVERNOTE_HOST = "www.evernote.com"
  # evernote_host = "sandbox.evernote.com"

  def self.create_note_store(auth_token, evernote_host)
    user_store_url = "https://#{evernote_host}/edam/user"
    user_store_transport = Thrift::HTTPClientTransport.new(user_store_url)
    user_store_protocol = Thrift::BinaryProtocol.new(user_store_transport)
    user_store = Evernote::EDAM::UserStore::UserStore::Client.new(user_store_protocol)
    version_ok = user_store.checkVersion("Evernote EDAMTest (Ruby)",
              Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR,
              Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)
    puts "Is my Evernote API version up to date? #{version_ok}"
    exit(1) unless version_ok
    begin
      note_store_url = user_store.getNoteStoreUrl(auth_token)
    rescue Evernote::EDAM::Error::EDAMUserException => edue
      ## See EDAMErrorCode enumeration for error code explanation
      ## http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
      Rails.logger.error "Evernote didn't authenticate b/c: #{edue.parameter}"
    raise
    end
    note_store_transport = Thrift::HTTPClientTransport.new(note_store_url)
    note_store_protocol = Thrift::BinaryProtocol.new(note_store_transport)

    Evernote::EDAM::NoteStore::NoteStore::Client.new(note_store_protocol)
  end

  def self.create_note_notebook_guid(note_notebook, auth_token, note_store)
    notebooks = note_store.listNotebooks(auth_token)
    notebooks.each do |notebook|
      if notebook.name == note_notebook
        return notebook.guid
      end
    end
  end

  def self.make_note_body(results)
    list = ''
    results.each do |row|
      list += "<en-todo/>#{row['total_quantity']} #{row['unit']} #{row['name']} <i>(#{row['recipe_names']})</i><br/>"
    end
    list
  end

  def self.make_note(note_store, note_title, note_body, auth_token, note_notebook_guid)
    n_body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    n_body += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
    n_body += "<en-note>#{note_body}</en-note>"

    our_note = Evernote::EDAM::Type::Note.new
    our_note.title = note_title
    our_note.content = n_body
    our_note.notebookGuid = note_notebook_guid

    begin
      note = note_store.createNote(auth_token, our_note)
    rescue Evernote::EDAM::Error::EDAMUserException => edue
      ## See EDAMErrorCode enumeration for error code explanation
      ## http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
      puts "EDAMUserException: #{edue}"
    rescue Evernote::EDAM::Error::EDAMNotFoundException => edue
      puts "EDAMNotFoundException: Invalid parent notebook GUID"
    end

    note
  end
end
