# require_relative "contact"
require_relative "rolodex"
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact 
  include DataMapper::Resource 

  property :id,Serial
  property :first_name,String 
  property :last_name,String
  property :email,String
  property :note,String

  # attr_accessor :first_name, :last_name, :email, :note, :id

  # def initialize(first_name,last_name,email,note)
  #   @first_name = first_name
  #   @last_name = last_name
  #   @email = email
  #   @note = note
  # end

DataMapper.finalize
DataMapper.auto_upgrade!

  # def print_rolo
  #   puts ""
  #   puts  "#{@first_name}  #{@last_name}  -  #{email}  :  #{note}  => #{@id}"
  #   puts ""
  # end
end

get '/' do
	@crm_app_name= "Sebastian's CRM App"
  erb :index
end

get "/contacts" do
  @contacts=Contact.all
	erb :all_contacts
end

get "/contact/new" do
	erb :add_contact
end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
	 erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i )
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

post '/contacts' do
  Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
     )

  redirect to('/contacts')
end


put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end