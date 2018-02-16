require_relative("../db/sql_runner")

class User

  attr_reader :id, :first_name, :last_name, :monthly_income, :budget

  def initialize(options)
    @id = options["id"].to_i
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @monthly_income = options["monthly_income"]
    @budget = options["budget"]
  end

  def pretty_name()
    return "#{@first_name} #{@last_name}"
  end

  def save()
    sql = "INSERT INTO users
    (first_name, last_name, monthly_income, budget)
    VALUES ($1, $2, $3, $4)
    RETURNING id"
    values = [@first_name, @last_name, @monthly_income, @budget]
    house_data = SqlRunner.run(sql, values)
    @id = house_data.first()["id"].to_i
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
