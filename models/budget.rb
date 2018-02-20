require_relative("../db/sql_runner")

class Budget

  def self.find_all_transactions_for_user(user_id)
    sql = "SELECT * FROM transactions WHERE user_id = $1 order by trans_date desc"
    values = [user_id]
    transactions = SqlRunner.run(sql, values)
    result = transactions.map { |transaction| Transaction.new(transaction) }
    return result
  end

  def self.total_recurring_transactions_for_user(user_id)
    sql = "SELECT sum(amount) FROM transactions WHERE user_id = $1 and recurring_transaction = $2"
    values = [user_id, "t"]
    recurring_transactions = SqlRunner.run(sql, values)
    return recurring_transactions.first.fetch("sum")
  end

  def self.total_non_recurring_transactions_for_user_since(id, p_date)
    last_pay_date = Date.new(p_date[0],p_date[1],p_date[2])
    sql = "SELECT sum(amount) FROM transactions
    WHERE user_id = $1
    and trans_date > $2
    and recurring_transaction = $3"
    values = [id, last_pay_date.to_s, "f"]
    non_recurring_transactions = SqlRunner.run(sql, values)
    return non_recurring_transactions.first.fetch("sum")
  end

  def self.deduct_transactions_from_budget(total_budget, total_recurring, total_non_recurring)
    result = total_budget.to_i- (total_recurring.to_i + total_non_recurring.to_i)
    return result
  end

  def self.calculate_remaining_budget(today, next_pay, remaining)
    current_date = Date.new(today[0], today[1], today[2])
    next_pay = Date.new(next_pay[0], next_pay[1], next_pay[2])
    days_to_pd = next_pay.to_date - current_date.to_date
    pounds_per_day = remaining.to_i / days_to_pd.to_i
    return days_to_pd, pounds_per_day
  end

  def self.todays_date()
    t_date = Date.parse(Date.today().to_s)
    current_date = t_date.mday.to_i
    current_month = t_date.mon.to_i
    current_year = t_date.year.to_i
    return current_year, current_month, current_date
  end

  def self.prev_pay_date(p_day, t_date)
    current_date = t_date[2].to_i
    prev_pay_date = p_day.to_i
    prev_pay_month = t_date[1].to_i
    prev_pay_year = t_date[0].to_i
    if prev_pay_date > current_date
      prev_pay_month -= 1
      if prev_pay_month == 0
        prev_pay_month = 12
        prev_pay_year -= 1
      end
    end
    return prev_pay_year, prev_pay_month, prev_pay_date
  end

  def self.next_pay_date(p_day, t_date)
    current_date = t_date[2].to_i
    next_pay_date = p_day.to_i
    next_pay_month = t_date[1].to_i
    next_pay_year = t_date[0].to_i
    if next_pay_date < current_date
      next_pay_month += 1
      if next_pay_month == 13
        next_pay_month = 1
        next_pay_year += 1
      end
    end
    return next_pay_year, next_pay_month, next_pay_date
  end

end
