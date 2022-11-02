class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  # creates table which is equal to the song class,where all individual songs will be stored.
  def self.create_table
    sql =  <<-SQL
    CREATE TABLE IF NOT EXISTS songs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      album TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end
  # Enter data into our songs table,INSERT INTO,create a instance method -save
  def save
    sql = <<-SQL
    INSERT INTO songs (name, album)
    VALUES (?, ?)
    SQL
# insert the song
    DB[:conn].execute(sql, self.name, self.album)

     # get the song ID from the database and save it to the Ruby instance
  
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    self

  end
  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save

  end
 end
