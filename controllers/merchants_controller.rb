require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/merchants.rb")

# index
get "/merchants" do
  @merchants = Merchant.all()
  erb ( :"merchants/index" )
end

# create
post "/merchants" do
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect "/merchants"
end

# add
get "/merchants/add" do
  erb(:"merchants/new")
end
