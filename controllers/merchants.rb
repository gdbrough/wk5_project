require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/merchants.rb")

# index
get "/merchants" do
  @merchants = Merchant.all()
  erb ( :"merchants/index" )
end
