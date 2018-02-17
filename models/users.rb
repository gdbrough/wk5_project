require_relative("../db/sql_runner")

class User

  attr_reader :id, :first_name, :last_name, :monthly_income, :budget, :pay_date

  def initialize(options)
    @id = options["id"].to_i
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @monthly_income = options["monthly_income"]
    @budget = options["budget"]
    @pay_date = options["pay_date"]
  end

  def pretty_name()
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = "INSERT INTO users
    (first_name, last_name, monthly_income, budget, pay_date)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id"
    values = [@first_name, @last_name, @monthly_income, @budget, @pay_date]
    house_data = SqlRunner.run(sql, values)
    @id = house_data.first()["id"].to_i
  end

  def update()
    sql = "UPDATE users SET first_name = $1, last_name = $2,
    monthly_income = $3, budget = $4, pay_date = $5
    where id = $6"
    values = [@first_name, @last_name, @monthly_income, @budget, @pay_date, @id]
    user = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM users"
    users = SqlRunner.run(sql)
    result = users.map { |user| User.new(user) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM users WHERE id = $1"
    values = [id]
    user = SqlRunner.run(sql, values)
    result = User.new(user.first)
    return result
  end

end
