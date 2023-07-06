require_relative './author'
require_relative './game'
require 'json'


def print_options
    my_function {
      puts 'Please choose the options:'
      puts '1. List all games'
      puts '2. List all authors'
      puts '3. Add a game'
      puts '4. Exit'
      print '>> '
    }
  end

class MaganeGame
#   attr_accessor :games, :authors

#   def initialize
#     @games = []
#     @authors = []
#   end

#   def start
    loop do
      puts ''
      print_options.call
      option = gets.chomp.to_i
      case option
      when 1
        display_games.call
      when 2
        display_authors.call
      when 3
        create_game.call
      when 4
        break
      else
        puts 'Invalid option. please re-enter.'
      end
    end
  end

#   private
  def create_game
    my_function {
      puts ''
      print 'Please enter author\'s first_name'
      first_name = gets.chomp
      print 'Please enter author\'s last_name '
      last_name = gets.chomp
      print 'Are multiplayer option available? (Y/N): '
      multiplayer_game = gets.chomp.downcase == 'y'
      print 'Please enter last_played_date (DD/MM/YYYY): '
      last_played_date = gets.chomp
      print 'Please enter game_published_date (DD/MM/YYYY): '
      released_date = gets.chomp

      game = Game.new(multiplayer_game, last_played_date, released_date, archived: false)
      author = Author.new(first_name, last_name)
      author.add_item(game)

      @games << game
      @authors << author

      puts "\nSuccessfully added new game"
    }
    
    preserve_game
    preserve_author

  end

  def display_games
    my_function {
      puts ''
      if @games.empty?
        puts 'No record for game found'
      else
        puts 'List of Games:'
        @games.each do |game|
          puts '......................................................'
          puts "Author: #{game.author.full_name}"
          puts "Last Played Date: #{game.last_played_date}"
          puts "Publish Date: #{game.released_date}"
          puts '......................................................'
        end
      end
    }
  end

  def display_authors
    my_function {
      puts ''
      if @authors.empty?
        puts 'No record for authors found'
      else
        puts 'List of Authors:'
        authors.each_with_index do |author, index|
          puts "Author #{index + 1}: #{author.full_name}"
        end
      end
    }
  end
  def preserve_game
    json = []
    @games.each do |game|
      json << game.to_json
    end
    File.write('db/game.json', JSON.pretty_generate(json))
  end
  
  def preserve_author
    json = []
    @authors.each do |_author|
      json << game.to_json
    end
    File.write('db/authors.json', JSON.pretty_generate(json))
  end
  
  def load_games
    return unless File.exist?('db/games.json')
    return if File.empty?('db/games.json')
  
    games = JSON.parse(File.read('db/games.json'))
    games.each do |game|
      @games << Game.new(game['last_played_at'], game['publish_date'], multiplayer: game['multiplayer'])
    end
  end
  
  def load_author
    return unless File.exist?('db/author.json')
    return if File.empty?('db/author.json')
  
    JSON.parse(File.read('db/authors.json'))
    author.each do |author|
      @author << Author.new(author['first_name'], author['last_name'])
    end
  end
  
  def load_games_data
    load_games
    load_authors
  end
end