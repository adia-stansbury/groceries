require "digest/md5"
require 'evernote-thrift'

module EvernoteApi
  NOTE_TITLE = 'Grocery List'
  NOTE_NOTEBOOK_NAME = 'Shopping List'
  EVERNOTE_HOST = "www.evernote.com"
  AUTH_TOKEN = ENV['PROD_AUTH_TOKEN']
  # EVERNOTE_HOST = "sandbox.evernote.com"
  # AUTH_TOKEN = ENV['SANDBOX_AUTH_TOKEN']

  def self.create_note(note_items, first_day_recipes)
    note_content = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    note_content += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
    note_content += "<en-note>#{note_body(note_items, first_day_recipes)}</en-note>"

    our_note = Evernote::EDAM::Type::Note.new
    our_note.title = NOTE_TITLE
    our_note.content = note_content
    our_note.notebookGuid = notebook.guid

    note_store.createNote(AUTH_TOKEN, our_note)

  rescue Evernote::EDAM::Error::EDAMUserException => edue
    ## See EDAMErrorCode enumeration for error code explanation
    ## http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
    puts "EDAMUserException: #{edue}"
  rescue Evernote::EDAM::Error::EDAMNotFoundException => edue
    puts "EDAMNotFoundException: Invalid parent notebook GUID"
  end

  private

  def self.protocol(url)
    transport = Thrift::HTTPClientTransport.new(url)

    Thrift::BinaryProtocol.new(transport)
  end

  def self.note_store
    user_store = Evernote::EDAM::UserStore::UserStore::Client.new(
      protocol("https://#{EVERNOTE_HOST}/edam/user")
    )
    version_ok = user_store.checkVersion(
      "Evernote EDAMTest (Ruby)",
      Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR,
      Evernote::EDAM::UserStore::EDAM_VERSION_MINOR
    )
    puts "Is my Evernote API version up to date? #{version_ok}"
    exit(1) unless version_ok

    Evernote::EDAM::NoteStore::NoteStore::Client.new(
      protocol(user_store.getNoteStoreUrl(AUTH_TOKEN))
    )

  rescue Evernote::EDAM::Error::EDAMUserException => edue
    ## See EDAMErrorCode enumeration for error code explanation
    ## http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
    Rails.logger.error "Evernote didn't authenticate b/c: #{edue.parameter}"
    raise
  end

  def self.notebook
    note_store.listNotebooks(AUTH_TOKEN).find do |notebook|
      notebook.name == NOTE_NOTEBOOK_NAME
    end
  end

  def self.note_body(note_items, first_day_recipes)
    list = ''
    note_items.each do |row|
      shared_recipes = row['recipe_names'].split('; ') & first_day_recipes
      if shared_recipes.empty?
        list += "<en-todo/>#{row['total_quantity']} #{row['unit']} #{row['name']} <i>(#{row['recipe_names']})</i><br/>"
      else
        list += "<en-todo/><strong>#{row['total_quantity']} #{row['unit']} #{row['name']}</strong> <i>(#{row['recipe_names']})</i><br/>"
      end
    end
    list
  end
end
