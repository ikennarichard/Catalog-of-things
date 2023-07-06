require_relative 'author'
require_relative 'game'
require 'json'

class GameHandler
  def initialize
    @games = []
    @authors = []
    load_games_data
  end

  def options
    my_function do
      puts 'Please choose an options:'
      puts '1. List all games'
      puts '2. List all authors'
      puts '3. Add new game'
      puts '4. Exit'
      print '>> '
    end
  end

  class ManageGame
    loop do
      puts ''
      options.call
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

  def create_game
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

    preserve_game
    preserve_author
  end

  def display_games
    my_function do
      puts ''
      if @games.empty?
        puts 'No record for game found'
      else
        puts 'List of all Games:'
        @games.each do |game|
          puts '......................................................'
          puts "Author: #{game.author.full_name}"
          puts "Last Played Date: #{game.last_played_date}"
          puts "Publish Date: #{game.released_date}"
          puts '......................................................'
        end
      end
    end
  end

  def display_authors
    my_function do
      puts ''
      if @authors.empty?
        puts 'No record for authors found'
      else
        puts 'List of all Authors:'
        authors.each_with_index do |author, index|
          puts "Author #{index + 1}: #{author.full_name}"
        end
      end
    end
  end

  def preserve_game
    json = []
    @games.each do |game|
      json << game.to_json
    end
    File.write('data/game.json', JSON.pretty_generate(json))
  end

  def preserve_author
    json = []
    @authors.each do |_author|
      json << game.to_json
    end
    File.write('data/author.json', JSON.pretty_generate(json))
  end

  def retrieve_data
    retrieve_game
    retrieve_authors
  end

  def retrieve_game
    return unless File.exist?('data/game.json')
    return if File.empty?('data/game.json')

    games = JSON.parse(File.read('data/game.json'))
    @games = games.map do |game|
      Game.new(game['multiplayer_game'], game['last_played_date'], game['released_date'], archived: false)
    end
  end

  def retrieve_author
    return unless File.exist?('data/author.json')
    return if File.empty?('data/author.json')

    authors = JSON.parse(File.read('data/author.json'))
    @authors = authors.map do |author|
      Author.new(author['first_name'], author['last_name'])
    end
  end
end
