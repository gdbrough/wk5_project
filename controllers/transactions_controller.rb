require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/transactions.rb")
require_relative("../models/merchants.rb")
require_relative("../models/users.rb")

# index
get "/transactions" do
  @transactions = Transaction.all()
  erb ( :"transactions/index" )
end

# create
post "/transactions" do
  @transaction = Transaction.new(params)
  @transaction.save()
  redirect "/transactions"
end

# add
get "/transactions/add" do
  @merchants = Merchant.all()
  @users = User.all()
  erb(:"transactions/new")
end
