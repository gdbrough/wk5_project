require_relative("../db/sql_runner")

class Tag

  attr_reader :id, :tag_name

  def initialize(options)
    @id = options["id"].to_i
    @tag_name = options["tag_name"]
  end

  def save()
    sql = "INSERT INTO tags
    (tag_name)
    VALUES ($1)
    RETURNING id"
    values = [@tag_name]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data.first()["id"].to_i
  end

  def update()
    sql = "UPDATE tags SET tag_name = $1
    where id = $2"
    values = [@tag_name, @id]
    user = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM tags"
    tags = SqlRunner.run(sql)
    result = tags.map { |tag| Tag.new(tag) }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1 ORDER BY id"
    values = [id]
    tag = SqlRunner.run(sql, values)
    result = Tag.new(tag.first)
  end

  def self.delete_all()
    sql = "DELETE FROM tags;"
    SqlRunner.run(sql)
  end

end
