require "digest/md5"
require 'evernote-thrift'

class EvernoteApi
  NOTE_TITLE = 'Grocery List'
  NOTE_NOTEBOOK_NAME = 'Shopping List'
  EVERNOTE_HOST = "www.evernote.com"
  AUTH_TOKEN = ENV['PROD_AUTH_TOKEN']
  # EVERNOTE_HOST = "sandbox.evernote.com"
  # AUTH_TOKEN = ENV['SANDBOX_AUTH_TOKEN']

  def initialize(items)
    @items = items
  end

  def create_note
    note_store.createNote(AUTH_TOKEN, build_note)

  rescue Evernote::EDAM::Error::EDAMUserException => edue
    ## See EDAMErrorCode enumeration for error code explanation
    ## http://dev.evernote.com/documentation/reference/Errors.html#Enum_EDAMErrorCode
    puts "EDAMUserException: #{edue}"
  rescue Evernote::EDAM::Error::EDAMNotFoundException => edue
    puts "EDAMNotFoundException: Invalid parent notebook GUID"
  end

  private

  def protocol(url)
    transport = Thrift::HTTPClientTransport.new(url)

    Thrift::BinaryProtocol.new(transport)
  end

  def note_store
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

  def notebook
    note_store.listNotebooks(AUTH_TOKEN).find do |notebook|
      notebook.name == NOTE_NOTEBOOK_NAME
    end
  end

  def note_body
    body = ''
    @items.each do |row|
      font_weight = row['is_for_first_day'] ? 'strong' : 'regular'
      body += "<en-todo/><#{font_weight}>#{row['total_quantity']} #{row['unit']} #{row['name']}</#{font_weight}> <i>(#{row['recipe_names']})</i><br/>"
    end

    body
  end

  def note_content
    content = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    content += "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">"
    content += "<en-note>#{note_body}</en-note>"

    content
  end

  def build_note
    note = Evernote::EDAM::Type::Note.new
    note.title = NOTE_TITLE
    note.content = note_content
    note.notebookGuid = notebook.guid

    note
  end
end
