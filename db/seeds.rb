require_relative("../models/users.rb")
require_relative("../models/merchants.rb")
require_relative("../models/transactions.rb")
require("pry-byebug")

user1 = User.new({
  "first_name" => "1st",
  "last_name" => "User",
  "monthly_income" => 2000,
  "budget" => 500,
  "pay_date" => 1
})
user2 = User.new({
  "first_name" => "2nd",
  "last_name" => "User",
  "monthly_income" => 2500,
  "budget" => 2000,
  "pay_date" => 15
})
user3 = User.new({
  "first_name" => "3rd",
  "last_name" => "User",
  "monthly_income" => 2000,
  "budget" => 1000,
  "pay_date" => 28
})

user1.save()
user2.save()
user3.save()

merchant1 = Merchant.new({
  "merchant_name" => "Tesco"
})
merchant2 = Merchant.new({
  "merchant_name" => "Morrisons"
})
merchant3 = Merchant.new({
  "merchant_name" => "Scottish Power"
})
merchant4 = Merchant.new({
  "merchant_name" => "Scottish Gas"
})
merchant5 = Merchant.new({
  "merchant_name" => "Nationwide"
})

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()
merchant5.save()

transaction1 = Transaction.new({
  "user_id" => user1.id,
  "merchant_id" => merchant1.id,
  "amount" => 27,
  "tag" => "groceries",
  "trans_date" => "20180216",
  "recurring_transaction" => false
})
transaction2 = Transaction.new({
  "user_id" => user1.id,
  "merchant_id" => merchant2.id,
  "amount" => 42,
  "tag" => "more groceries",
  "trans_date" => "20180216",
  "recurring_transaction" => false
})
transaction3 = Transaction.new({
  "user_id" => user1.id,
  "merchant_id" => merchant3.id,
  "amount" => 50,
  "tag" => "power",
  "trans_date" => "20180216",
  "recurring_transaction" => false
})
transaction4 = Transaction.new({
  "user_id" => user1.id,
  "merchant_id" => merchant4.id,
  "amount" => 30,
  "tag" => "gas",
  "trans_date" => "20180216",
  "recurring_transaction" => false
})
transaction5 = Transaction.new({
  "user_id" => user2.id,
  "merchant_id" => merchant1.id,
  "amount" => 12,
  "tag" => "groceries",
  "trans_date" => "20180216",
  "recurring_transaction" => false
})
transaction6 = Transaction.new({
  "user_id" => user1.id,
  "merchant_id" => merchant5.id,
  "amount" => 550,
  "tag" => "mortgage",
  "trans_date" => "20180216",
  "recurring_transaction" => false
})

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()
transaction6.save()
