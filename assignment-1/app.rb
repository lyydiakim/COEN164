require 'sinatra'
require 'sinatra/reloader'
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/database.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :password, String
  property :profit, Integer
  property :loss, Integer
  property :win, Integer
end

DataMapper.finalize.auto_upgrade!

configure do
  enable :sessions

  set :name, ''
  set :password, ''
  set :win, ''
  set :loss, ''
  set :profit, ''
end

# index page
get '/' do
  erb :index
end


get '/logon' do
  erb :logon
end

post '/logon' do
    name = params[:name]
    password = params[:password]

    user = User.all(:name.like => name)[0]

    if user && user.password == password
      # Username exists and password matches
      session[:user_id] = user.id
      session[:name] = params[:name]
      session[:win] = 0
      session[:loss] = 0
      session[:profit] = 0

      redirect '/play'
    else # Username doesn't exist or password doesn't match
      redirect '/signup'
    end   
end

get '/signup' do
  erb :signup
end

post '/signup' do 
  name = params[:name]
  password = params[:password]

  user = User.all(:name.like => name)[0]

  if user  #if the username already exists
     redirect '/logon'
  else  
    session[:name] = name  # Store name in session
    session[:password] = password  
    User.create(name: name, password: password, win: 0, loss: 0, profit: 0)

    session[:win] = 0
    session[:loss] = 0
    session[:profit] = 0
    redirect '/play'
  end
end

get '/play' do
  
  name = session[:name]
  password = session[:password]

  @user = User.get(name)
  user = User.all(:name.like => name)[0]


  @accountwin = user.win
  @accountloss = user.loss
  @accountprofit = user.profit

  @current_win = session[:win]
  @current_loss = session[:loss]
  @current_profit = session[:profit]
  

  erb :play
end

post '/play' do

  dicenum = params[:dicenum].to_i
  winning_number = rand(1..6)
  bet = params[:bet].to_i


  if session[:won] = (dicenum == winning_number)
    bet = bet * 2      #win twice your money
    session[:win] +=  bet 
    session[:profit] += bet 
    @current_win = session[:win]
    @current_loss = session[:loss]
    @current_profit = session[:profit]
  else
    session[:loss] += bet 
    session[:profit] -= bet
    @current_win = session[:win]
    @current_loss = session[:loss]
    @current_profit = session[:profit]
  end

  name = session[:name]
  @user = User.get(:user_id)
  user = User.all(:name.like => name)[0]


  @accountwin = user.win
  @accountloss = user.loss
  @accountprofit = user.profit

  @accountwin += @current_win
  @accountloss += @current_loss
  @accountprofit += @current_profit
  
  

  erb :play
end

post '/logout' do
  name = session[:name]
  @user = User.get(:user_id)
  user = User.all(:name.like => name)[0]
  user.win = session[:win] + user.win
  user.loss = session[:loss] + user.loss
  user.profit = session[:profit] + user.profit
  user.save
  session.clear

  redirect '/' 
end