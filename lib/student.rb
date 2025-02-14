class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
@@all=[]
attr_accessor :name, :grade
attr_reader :id
def initialize(id=nil,name,grade)
  @id = id
  @name=name
  @grade=grade
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_table
    sql= <<-SQL
     CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql= <<-SQL
    INSERT INTO students(name,grade)
    VALUES (?,?)
    SQL

  DB[:conn].execute(sql,self.name,self.grade)
  @id=DB[:conn].execute("SELECT LAST_insert_rowid() from students")[0][0]
  end

  def self.drop_table
    sql= <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

def self.create(name:,grade:)
  student=Student.new(name,grade)
  student.save
student
end
end
