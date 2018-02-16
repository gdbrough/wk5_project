require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/users.rb")

# index
get "/users" do
  @users = User.all()
  erb ( :"users/index" )
end

# create
post "/users" do
  @user = User.new(params)
  @user.save()
  redirect "/users"
end

# add
get "/users/add" do
  erb(:"users/new")
end
