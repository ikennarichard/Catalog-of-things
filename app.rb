require_relative 'genre'
require_relative 'music_album'
require 'json'
class App
  attr_accessor :books, :music_albums, :games

  def initialize
    @books = []
    @music_albums = []
    @games = []
  end

  def options
    puts ''
    puts 'Please select an option by entering a number:'
    puts '1. Manage Books'
    puts '2. Manage Music Albums'
    puts '3. Manage Games'
    puts '4. Exit'
  end

  def invalid_option; end

  def list_music_albums
    @music_albums = File.read('./data/music_albums.json').empty? ? [] : JSON.parse(File.read('./data/music_albums.json'))

    if @music_albums.empty?
      puts ' No albums yet! please add one '
    else
      puts 'Album details'
      @music_albums.each do |album|
        puts "Album title: #{album['title']} - Release year: #{album['publish_date']} - Music genre: #{album['genre'].upcase} on_Spotify: #{album['on_spotify'] == true ? 'Yes' : 'No'}"
      end
      puts
    end
  end

  def list_all_genres
    @music_albums = File.read('./data/music_albums.json').empty? ? [] : JSON.parse(File.read('./data/music_albums.json'))

    if @music_albums.empty?
      puts 'No genres found in the catalog'
    else
      @music_albums.each_with_index do |album, index|
        puts "#{index+1}. #{album['genre'].upcase}"
      end
    end
  end

  def add_music_album
    @music_albums = File.read('./data/music_albums.json').empty? ? [] : JSON.parse(File.read('./data/music_albums.json'))

    print ' Enter album title: '
    title = gets.chomp
    print 'Enter date of release (YYYY-M-D): '
    publish_date = gets.chomp
    print 'Album listed on spotify? (Y/N): '
    on_spotify = gets.chomp.downcase == 'y'
    print ' Enter the genre of the album music: '
    genre = gets.chomp

    album = MusicAlbum.new(title)
    album.publish_date = publish_date
    album.on_spotify = on_spotify
    genre = Genre.new genre
    genre.add_item(album)

    album_data = {
      'id' => album.id,
      'title' => album.title,
      'on_spotify' => album.on_spotify,
      'genre' => album.genre.name,
      'publish_date' => album.publish_date,
    }

    @music_albums << album_data
    puts "#{album.title.capitalize} was added successfully"


    File.write('./data/music_albums.json', JSON.generate(music_albums))
  end
end
