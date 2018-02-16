require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/transactions.rb")

# index
get "/transactions" do
  @transactions = Transaction.all()
  erb ( :"transactions/index" )
end
