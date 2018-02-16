require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/users.rb")
# require_relative("controllers/merchants.rb")
# require_relative("controllers/transactions.rb")

get '/' do
  erb( :index )
end
