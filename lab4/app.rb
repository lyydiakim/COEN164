require 'sinatra'
require 'sinatra/reloader'

# Configure block to initialize and retrieve account information
configure do
  set :name, ''
  set :account_id, ''
  set :balance, 0
end

# renders out the root page with links (index)
get '/' do
  erb :index
end

get '/error' do
  erb :error
end

# Open Account form
get '/open_account' do
  erb :open_account
end

# Process Open Account form submission
post '/open_account' do
  settings.name = params[:name]
  settings.account_id = params[:account_id]
  redirect '/'
end

# Deposit form
get '/deposit' do
  erb :deposit
end

# Process Deposit form submission
post '/deposit' do
  if settings.account_id.empty?
    redirect '/error'
  end
  
  if params[:amount].to_i < 0
    redirect '/error'
  else
    amount = params[:amount].to_i
    settings.balance += amount
    redirect '/' 
  end
end

# Withdraw form
get '/withdraw' do
  erb :withdraw, locals: {insufficient_funds: session.delete(:insufficient_funds) }
end

# Process Withdraw form submission
post '/withdraw' do
  
  if settings.account_id.empty?
    redirect '/error'
  end


  amount = params[:amount].to_i 

  if params[:amount].to_i < 0
    redirect '/error'
  end
  
  if amount > settings.balance
    redirect '/error'
  else
    settings.balance -= amount
    redirect '/'    
    end
end

