require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/users.rb")

# index
get "/users" do
  @users = User.all()
  erb (:"users/index")
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

# edit
get "/users/:id/edit" do
  @user = User.find(params[:id])
  erb(:"users/edit")
end

# edit
post "/users/:id" do
  @user = User.new(params)
  @user.update()
  redirect "/users"
end

# delete
post "/users/:id/delete" do
  @order = User.new(params)
  @order.delete()
  redirect "/users"
end

#show
get "/users/:id" do
  @user = User.find(params[:id])
  erb(:"users/show")
end
