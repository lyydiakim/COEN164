# The variables arent showing up in the broswse
require 'sinatra'
require 'sinatra/reloader'
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/database.db")

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :account_id, Integer
  property :balance, Integer

end

DataMapper.finalize.auto_upgrade!

configure do
  set :name, ''
  set :account_id, ''
  set :balance, 0
end

get '/error' do
  erb :error
end

# Renders the root page with links (index)
get '/' do
  @user= User.all
  erb :users
end


# Form for adding user details
get '/new' do
  erb :new_user
end

# create a new user
post '/new_user' do
  user = User.create(name: params[:name], account_id: params[:account_id], balance: params[:balance])
  user.save 
  redirect '/'
end

# Individual user detail view
get '/:id' do
  @user = User.get(params[:id])
  erb :user_detail
end