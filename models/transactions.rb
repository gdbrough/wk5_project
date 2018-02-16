require_relative("../db/sql_runner")

class Transaction

  attr_reader :id, :user_id, :merchant_id, :amount, :tag, :trans_date

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @merchant_id = options["merchant_id"]
    @amount = options["amount"]
    @tag = options["tag"]
    @trans_date = options["trans_date"]
  end

  def save()
    sql = "INSERT INTO transactions
    (user_id, merchant_id, amount, tag, trans_date)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id"
    values = [@user_id, @merchant_id, @amount, @tag, @trans_date]
    transaction = SqlRunner.run(sql, values)
    @id = transaction.first()["id"].to_i
  end

  def find_user()
    sql = "SELECT * FROM users WHERE id = $1"
    values = [@user_id]
    user = SqlRunner.run(sql, values)
    result = User.new(user.first)
    return result
  end

  def find_merchant()
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [@merchant_id]
    merchant = SqlRunner.run(sql, values)
    result = Merchant.new(merchant.first)
    return result
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run(sql)
    result = transactions.map { |transaction| Transaction.new(transaction) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run(sql, values)
    result = Transaction.new(transaction.first)
    return result
  end

end
