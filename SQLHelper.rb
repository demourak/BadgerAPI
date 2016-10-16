require 'active_record'

class User < ActiveRecord::Base
end

class SQLHelper < ActiveRecord::Migration

	SQLUsername = 'badgeradmin'
	SQLPassword = 'AppBadger1!'
	
	def initialize
		ActiveRecord::Base.establish_connection(
			:adapter  => "mysql2",
			:host     => "badgerdb.cz2y13cetnjg.us-west-2.rds.amazonaws.com",
			:username => SQLUsername,
			:password => SQLPassword,
			:database => "BadgerDB"
		)

	end
	
	def getFirstUser
	  user = User.find(1)
	  user.username
	end
	
	def getUserById(id)
	  begin
		user = User.find(id)
		rescue ActiveRecord::RecordNotFound
		  return {:error => "User not found."}
		else
		  {:id => user.id, :username => user.username}
		end
	end
	
	def createUser(name)
		begin
		user = User.create(:username => name)
		rescue ActiveRecord::RecordNotUnique => e
			return {:error => "Username already exists"}
		else
			JSON.pretty_generate(array)
			{:id => user.id, :username => user.username}
		end
	end
end