require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")

require_relative("../models/transactions.rb")
require_relative("../models/merchants.rb")
require_relative("../models/users.rb")
require_relative("../models/tags.rb")

# index
get "/transactions" do
  @transactions = Transaction.all()
  erb (:"transactions/index")
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
  @tags = Tag.all()
  erb(:"transactions/new")
end

# edit
get "/transactions/:id/edit" do
  @transaction = Transaction.find(params[:id])
  @merchants = Merchant.all()
  @users = User.all()
  @tags = Tag.all()
  erb(:"transactions/edit")
end

# edit
post "/transactions/:id" do
  @transaction = Transaction.new(params)
  @transaction.update()
  redirect "/transactions"
end

# delete
post "/transactions/:id/delete" do
  @transaction = Transaction.new(params)
  @transaction.delete()
  redirect "/transactions"
end

#show
get "/transactions/:id" do
  @transaction = Transaction.find(params[:id])
  erb(:"transactions/show")
end

# binding.pry
# nil
