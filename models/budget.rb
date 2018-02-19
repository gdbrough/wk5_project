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

  def self.total_recurring_transactions_for_user(user_id)
    sql = "SELECT sum(amount) FROM transactions WHERE user_id = $1 and recurring_transaction = $2"
    values = [user_id, "t"]
    recurring_transactions = SqlRunner.run(sql, values)   #.first[:sum].to_s
    result = recurring_transactions.map { |transaction| Transaction.new(transaction) }
    return recurring_transactions.first.fetch("sum")
    # return result
  end

  def self.todays_date()
    t_date = Date.parse(Date.today().to_s)
    current_date = t_date.mday.to_i
    current_month = t_date.mon.to_i
    current_year = t_date.year.to_i
    return current_year, current_month, current_date
  end

  def self.next_pay_date(p_day, t_date)
    current_date = t_date[2].to_i
    next_pay_date = p_day.to_i
    next_pay_month = t_date[1].to_i
    next_pay_year = t_date[0].to_i
    if next_pay_date < current_date
      next_pay_month = next_pay_month + 1
      if next_pay_month == 13
        next_pay_month = 1
        next_pay_year += 1
      end
    end
    return next_pay_year, next_pay_month, next_pay_date
  end


  # def date_stuff
  #   date_sent = Date.parse('2007-01-01')
  #   date_now = Date.today
  #   how_many_days_have_passed = (date_now - date_sent).to_i
  # end

end
