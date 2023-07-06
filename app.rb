require 'json'
# require_relative 'date'
require_relative 'book'
require_relative 'label'
require_relative 'genre'
require_relative 'music_album'
require_relative 'game'
require_relative 'author'

class App
  attr_accessor :books, :music_albums, :games

  def initialize
    @books = []
    @music_albums = []
    @games = []
    @authors = []
    retrieve_data
  end

  # games and author
  def create_game
    puts ''
    print 'Please enter author\'s first_name: '
    first_name = gets.chomp
    print 'Please enter author\'s last_name: '
    last_name = gets.chomp
    print 'Are multiplayers option available? (Y/N): '
    multiplayer_game = gets.chomp.downcase == 'y'
    print 'Please enter last_played_date (DD/MM/YYYY): '
    last_played_date = gets.chomp
    print 'Please enter game_published_date (DD/MM/YYYY): '
    released_date = gets.chomp
    game = Game.new(multiplayer_game, last_played_date, released_date, archived: false)
    author = Author.new(first_name, last_name)
    author.add_item(game)
    @games << { 'id' => game.id, 'multiplayer_game' => game.multiplayer, 'last_played_date' => game.last_played_at,
                'released_date' => game.publish_date }
    @authors << { 'first_name' => game.author.first_name, 'last_name' => game.author.last_name }
    puts "\nSuccessfully added new game"
    preserve_game(@games)
    preserve_author(@authors)
  end

  def display_games
    puts ''
    if @games.empty?
      puts 'No record for game found'
    else
      puts 'List of all Games:'
      @games.each do |game|
        puts '......................................................'
        puts "Game_ID: #{game['id']}"
        puts "Multiplayer: #{game['multiplayer_game'] ? 'Yes' : 'No'}"
        puts "Last Played Date: #{game['last_played_date']}"
        puts "Publish Date: #{game['released_date']}"
        puts '......................................................'
        puts ''
      end
    end
    retrieve_data
  end

  def display_authors
    puts ''
    if @authors.empty?
      puts 'No record for authors found'
    else
      puts 'List of all Authors:'
      @authors.each_with_index do |author, _index|
        puts "Author's Name: #{author['first_name']} #{author['last_name']}"
      end
    end
    retrieve_data
  end

  def preserve_game(game)
    File.write('data/game.json', JSON.generate(game))
  end

  def preserve_author(author)
    File.write('data/author.json', JSON.generate(author))
  end

  def retrieve_data
    retrieve_game
    retrieve_author
  end

  def retrieve_game
    return unless File.exist?('data/game.json')

    @games = File.empty?('./data/game.json') ? [] : JSON.parse(File.read('data/game.json'))
  end

  def retrieve_author
    return unless File.exist?('data/author.json')

    @authors = File.empty?('./data/author.json') ? [] : JSON.parse(File.read('data/author.json'))
  end

  def to_json(param)
    {
      'id' => param.id,
      'multiplayer' => param.multiplayer,
      'last_played_at' => param.last_played_at,
      'publish_date' => param.publish_date,
      'archived' => param.archived
    }
  end

  # music albums
  def list_music_albums
    @music_albums = File.empty?('./data/music_albums.json') ? [] : JSON.parse(File.read('./data/music_albums.json'))
    if @music_albums.empty?
      puts ' No albums yet! please add one '
    else
      puts 'Album details'
      @music_albums.each do |album|
        puts "Title: #{album['title']} - Release year: #{album['publish_date']} - " \
             "Music genre: #{album['genre'].upcase} on_Spotify: #{album['on_spotify'] ? 'Yes' : 'No'}"
      end
      puts
    end
  end

  def list_all_genres
    @music_albums = File.empty?('./data/music_albums.json') ? [] : JSON.parse(File.read('./data/music_albums.json'))
    if @music_albums.empty?
      puts 'No genres found in the catalog'
    else
      @music_albums.each_with_index do |album, index|
        puts "#{index + 1}. #{album['genre'].upcase}"
      end
    end
  end

  def add_music_album
    @music_albums = File.empty?('./data/music_albums.json') ? [] : JSON.parse(File.read('./data/music_albums.json'))
    print 'Enter album title: '
    title = gets.chomp
    print 'Enter date of release (YYYY-M-D): '
    publish_date = gets.chomp
    print 'Album listed on spotify? (Y/N): '
    on_spotify = gets.chomp.downcase == 'y'
    print 'Enter the genre of the album music: '
    genre = gets.chomp
    album = MusicAlbum.new(title)
    album.publish_date = publish_date
    album.on_spotify = on_spotify
    genre = Genre.new genre
    genre.add_item(album)
    album_data = to_h(album)
    @music_albums << album_data
    puts "#{album.title.capitalize} was added successfully"
    puts ''
    File.write('./data/music_albums.json', JSON.generate(music_albums))
  end

  def to_h(album)
    {
      'id' => album.id,
      'title' => album.title,
      'on_spotify' => album.on_spotify,
      'genre' => album.genre.name,
      'publish_date' => album.publish_date
    }
  end

  # //////////////BOOKS////////////////
  
  def list_books
    if File.exist?('./data/books.json')
      @books = JSON.parse(File.read('./data/books.json')) rescue []
    else
      @books = []
    end
  
    if @books.empty?
      puts 'No books found'
    else
      puts 'List of Books:'
      @books.each_with_index do |book, index|
        puts "#{index + 1} Publisher: #{book['publisher']}, Cover State: #{book['cover_state']}, Publish Date: #{book['publish_date']}"
      end
    end
  end
  
  
  def list_labels
    if File.exist?('./data/labels.json')
      @labels = JSON.parse(File.read('./data/labels.json')) rescue []
    else
      @labels = []
    end
  
    if @labels.empty?
      puts 'No labels found'
    else
      @labels.each_with_index do |label, index|
        puts "#{index + 1}) Title: #{label['title']}, Color: #{label['color']}"
      end
    end
  end
  
  
    def add_book
      @books = File.exist?('./data/books.json') ? JSON.parse(File.read('./data/books.json')) : []
      print 'Enter publisher: '
      publisher = gets.chomp
    
      print 'Enter cover state: '
      cover_state = gets.chomp
    
      print 'Enter publish date (yyyy-mm-dd): '
      publish_date_str = gets.chomp
      publish_date = Date.parse(publish_date_str) rescue nil
    
      if publisher.empty? || cover_state.empty? || publish_date.nil?
        puts 'Invalid input. Book not added.'
      else
        book = Book.new(publisher, cover_state, publish_date&.to_s || '')
        @books << { 'publisher' => book.publisher, 'cover_state' => book.cover_state, 'publish_date' => book.publish_date }
        File.write('./data/books.json', JSON.generate(@books))
        puts 'Book added successfully!'
      end
    end    
    
    def add_label
      @labels = File.exist?('./data/labels.json') ? JSON.parse(File.read('./data/labels.json')) : []
      print 'Enter title: '
      title = gets.chomp
    
      print 'Enter color: '
      color = gets.chomp
    
      if title.empty? || color.empty?
        puts 'Invalid input. Label not added.'
      else
        label = Label.new(title, color)
        @labels << label
        File.write('./data/labels.json', JSON.generate(@labels.map(&:to_h)))
        puts 'Label added successfully!'
      end
    end

end

