require "digest/md5"
require 'evernote-thrift'

class ListsController < ApplicationController
  def new
    recipe_ids = params['recipe_ids']
    @groups = NutrientGroup.all.order(:name)
    #all of the ingredient ids that belong to recipe ids
    @recipe_ingredient_ids = RecipeIngredient.where(recipe_id: recipe_ids).
      uniq.pluck(:ingredient_id) 
    note_title = 'Grocery List'
    note_notebook = 'Cooking'
    db_name = 'recipes'
    #auth_token = ENV['SANDBOX_AUTH_TOKEN']
    auth_token = ENV['PROD_AUTH_TOKEN']
    #evernote_host = "sandbox.evernote.com"
    evernote_host = "www.evernote.com"

    def create_note_store(auth_token, evernote_host)
      user_store_url = "https://#{evernote_host}/edam/user"
      user_store_transport = Thrift::HTTPClientTransport.new(user_store_url)
      user_store_protocol = Thrift::BinaryProtocol.new(user_store_transport)
      user_store = Evernote::EDAM::UserStore::UserStore::Client.new(user_store_protocol)
      version_ok = user_store.checkVersion("Evernote EDAMTest (Ruby)",
                Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR,
                Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)
      puts "Is my Evernote API version up to date? #{version_ok}"
      exit(1) unless version_ok
      note_store_url = user_store.getNoteStoreUrl(auth_token)
      note_store_transport = Thrift::HTTPClientTransport.new(note_store_url)
      note_store_protocol = Thrift::BinaryProtocol.new(note_store_transport)

      Evernote::EDAM::NoteStore::NoteStore::Client.new(note_store_protocol)
    end

    def create_note_notebook_guid(note_notebook, auth_token, note_store)
      notebooks = note_store.listNotebooks(auth_token)

      notebooks.each do |notebook|
        if notebook.name == note_notebook
          return notebook.guid
        end
      end 
    end 

    def make_note_body(results)
      list = ''

      results.each do |row|
        list += "<en-todo/>#{row.quantity} #{row.unit} #{row.ingredient.name}<br/>"
      end 

      list
    end 

    def make_note(note_store, note_title, note_body, auth_token, note_notebook_guid)
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

    results = RecipeIngredient.where(recipe_id: recipe_ids).
      includes(ingredient: :location).order("locations.ordering")

    note_store = create_note_store(auth_token, evernote_host)
    note_notebook_guid = create_note_notebook_guid(note_notebook, auth_token, note_store)
    note_body = make_note_body(results) 
    note = make_note(note_store, note_title, note_body, auth_token, note_notebook_guid)
  end
end
