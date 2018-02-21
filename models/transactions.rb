require_relative("../db/sql_runner")

class Transaction

  attr_reader :id, :user_id, :merchant_id, :amount, :tag_id, :trans_date, :recurring_transaction

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @merchant_id = options["merchant_id"]
    @amount = options["amount"]
    @tag_id = options["tag_id"]
    @trans_date = options["trans_date"]
    @recurring_transaction = options["recurring_transaction"]
  end

  def save()
    if @recurring_transaction != "t" && @recurring_transaction != true
      @recurring_transaction = "f"
    end
    sql = "INSERT INTO transactions
    (user_id, merchant_id, amount, tag_id, trans_date, recurring_transaction)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING id"
    values = [@user_id, @merchant_id, @amount, @tag_id, @trans_date, @recurring_transaction]
    transaction = SqlRunner.run(sql, values)
    @id = transaction.first()["id"].to_i
  end

  def update()
    @recurring_transaction = "f" if @recurring_transaction != "t"
    sql = "UPDATE transactions SET user_id = $1, merchant_id = $2,
    amount = $3, tag_id = $4, trans_date = $5, recurring_transaction = $6
    where id = $7"
    values = [@user_id, @merchant_id, @amount, @tag_id, @trans_date, @recurring_transaction, @id]
    transaction = SqlRunner.run(sql, values)
  end

  def find_user()
    sql = "SELECT * FROM users WHERE id = $1 ORDER BY id"
    values = [@user_id]
    user = SqlRunner.run(sql, values)
    result = User.new(user.first)
    return result
  end

  def find_merchant()
    sql = "SELECT * FROM merchants WHERE id = $1 ORDER BY id"
    values = [@merchant_id]
    merchant = SqlRunner.run(sql, values)
    result = Merchant.new(merchant.first)
    return result
  end

  def find_tag()
    sql = "SELECT * FROM tags WHERE id = $1 ORDER BY id"
    values = [@tag_id]
    tag = SqlRunner.run(sql, values)
    result = Tag.new(tag.first)
    return result
  end

  def delete()
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM transactions ORDER BY id"
    transactions = SqlRunner.run(sql)
    result = transactions.map { |transaction| Transaction.new(transaction) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1 ORDER BY id"
    values = [id]
    transaction = SqlRunner.run(sql, values)
    result = Transaction.new(transaction.first)
    return result
  end

  def self.find_by_tag(id)
    sql = "SELECT * FROM transactions WHERE tag_id = $1 ORDER BY id"
    values = [id]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map { |transaction| Transaction.new(transaction) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

end
