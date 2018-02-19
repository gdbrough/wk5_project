require("sinatra")
require("sinatra/contrib/all")
require_relative("controllers/users_controller.rb")
require_relative("controllers/merchants_controller.rb")
require_relative("controllers/transactions_controller.rb")
require_relative("controllers/budget_controller.rb")
require_relative("controllers/tags_controller.rb")

# User.delete_all()
# Merchant.delete_all()
# Transaction.delete_all()

get '/' do
  erb( :index )
end
