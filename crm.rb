require_relative "contact"
require_relative "rolodex"
require 'sinatra'

@@rolodex=Rolodex.new

get '/' do
	@crm_app_name= "Sebastian's CRM App"
  erb :index
end

get "/contacts" do
	erb :all_contacts
end

get "/contact/new" do
	erb :add_contact
end

get "/contacts/:id" do
	erb :show_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')
end