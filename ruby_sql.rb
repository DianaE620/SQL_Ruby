require 'sqlite3'

class Chef

  def initialize(first_name, last_name, birthday, email, phone, created_at = Time.now, updated_at = Time.now)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
    @created_at = created_at 
    @updated_at = updated_at

  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
        -- Añade aquí más registros
          ('Laura', 'Ortiz', '1990-03-19', 'lauris@hotmail.com', '56997786106', DATETIME('now'), DATETIME('now')),
          ('Roberto', 'Saldana', '1980-09-10', 'donrobert@gmail.com', '55978964258', DATETIME('now'), DATETIME('now')),
          ('Maria', 'Del Campo', '1995-10-05', 'marianita@yahoo.com', '55989965897', DATETIME('now'), DATETIME('now')),
          ('Bernardo', 'Lopez', '1890-12-12', 'elberna@gmail.com', '55659862165', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def self.all
    Chef.db.execute(
      # <<-SQL
        "SELECT * FROM chefs"
      # SQL
    )
    
  end

  def self.where(campo, valor)
    Chef.db.execute(
      # <<-SQL
        "SELECT * FROM chefs WHERE #{campo} = ?", "#{valor}"
      # SQL
    )  
  end

  def self.delete(campo, valor)
    Chef.db.execute(
      # <<-SQL
        "DELETE FROM chefs WHERE #{campo} = '#{valor}'"
      # SQL
    )  
  end

  def save
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('#{@first_name}', '#{@last_name}', '#{@birthday}', '#{@email}', '#{@phone}', '#{@created_at}', '#{@updated_at}');
      SQL
    )
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end

# chef_alberto = Chef.new("Alberto", "Lara", "1191-05-21", "albertol@gmail.com", "5516895623")

# p Chef.all

# p Chef.where('first_name','Roberto')
# p Chef.where('id',5)

# chef_alberto = Chef.new("Alberto", "Lara", "1191-05-21", "albertol@gmail.com", "5516895623")
# chef_alberto.save

Chef.delete('id', 2)
 

