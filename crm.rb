require_relative "contact"
require_relative "rolodex"
require 'sinatra'

get '/' do
	@crm_app_name= "My CRM"
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