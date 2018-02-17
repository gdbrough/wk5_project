require_relative("../db/sql_runner")

class Merchant

  attr_reader :id, :merchant_name

  def initialize(options)
    @id = options["id"]
    @merchant_name = options["merchant_name"]
  end

  def save()
    sql = "INSERT INTO merchants (merchant_name) VALUES ($1)
    RETURNING id"
    values = [@merchant_name]
    merchant = SqlRunner.run(sql, values)
    @id = merchant.first()["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET merchant_name = $1
    where id = $2"
    values = [@merchant_name, @id]
    merchant = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    result = merchants.map { |merchant| Merchant.new(merchant) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run(sql, values)
    result = Merchant.new(merchant.first)
    return result
  end

end
