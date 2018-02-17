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

# edit
get "/merchants/:id/edit" do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/edit")
end

# edit
post "/merchants/:id" do
  @merchant = Merchant.new(params)
  @merchant.update()
  redirect "/merchants"
end

# delete
post "/merchants/:id/delete" do
  @merchant = Merchant.new(params)
  @merchant.delete()
  redirect "/merchants"
end

#show
get "/merchants/:id" do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/show")
end
