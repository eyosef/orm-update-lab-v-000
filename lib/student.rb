require_relative "../config/environment.rb"
require 'pry'

class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table

    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER)
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save

    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

                  binding.pry

    DB[:conn].each do |row|
      if @id = row[0][0]
        row
      end

    end #each iterator

  end #save method

    def self.update
      sql <<-SQL
        UPDATE students
        SET name = ?,
        WHERE name = ?
      SQL
      DB[:conn].execute(sql, self.name, self.name)
    end #update method


  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end #class
