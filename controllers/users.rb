require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/users.rb")

# index
get "/users" do
  @users = User.all()
  erb ( :"users/index" )
end
