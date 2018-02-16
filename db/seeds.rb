require_relative("../models/users.rb")
require_relative("../models/merchants.rb")
require_relative("../models/transactions.rb")
require("pry-byebug")

user1 = User.new({
  "first_name" => "Roy",
  "last_name" => "Oftherovers",
  "monthly_income" => 2000,
  "budget" => 500
})

user1.save()

merchant1 = Merchant.new({
  "merchant_name" => "Tesco"
})

merchant1.save()

transaction1 = Transaction.new({
  "user_id" => user1.id,
  "merchant_id" => merchant1.id,
  "amount" => 27,
  "tag" => "groceries",
  "trans_date" => "20180216"
})

transaction1.save()
