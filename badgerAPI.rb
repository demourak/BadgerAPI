require 'sinatra'
require './SQLHelper'
require 'json'

get '/' do
  db = SQLHelper.new
end

get '/testConnection' do
  "Connected to Badger API!"
end

get '/getUser' do
  db = SQLHelper.new
  result = db.getUserById params['id']
	JSON.pretty_generate result
end

post '/createUser' do

    request.body.rewind
		args = JSON.parse request.body.read
		username = args['username']
	
		db = SQLHelper.new
		array = db.createUser username
	  JSON.pretty_generate array

end