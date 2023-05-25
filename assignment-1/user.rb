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