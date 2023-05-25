require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/database.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :account_id, Integer
  property :name, String
  property :balance, Integer
end

DataMapper.finalize.auto_upgrade!