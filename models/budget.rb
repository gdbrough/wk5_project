require_relative("../db/sql_runner")

class Budget

  attr_reader :user_id

  def initialize(options)
    @user_id = options("user_id")
  end

  def self.find_all_transactions_for_user(user_id)
    sql = "SELECT * FROM transactions WHERE user_id = $1"
    values = [user_id]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map { |transaction| Transaction.new(transaction) }
    return result
  end

end
