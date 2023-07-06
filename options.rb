require_relative 'app'
class Options
  def display_options
    puts 'Choose an option:'
    puts '1. List all genres'
    puts '2. Create an album'
    puts '3. List all music albums'
    puts '4. List all games'
    puts '5. List all authors'
    puts '6. Add new game'
    puts '7. Quit'
  end
  def process_option(app, option)
    actions = {
      1 => -> { app.list_all_genres },
      2 => -> { app.add_music_album },
      3 => -> { app.list_music_albums },
      4 => -> { app.display_games },
      5 => -> { app.display_authors },
      6 => -> { app.create_game },
      7 => -> { puts 'Exiting the app...‍:rocket:' }
    }
    action = actions[option]
    if action
      action.call
      option != 7
    else
      puts 'Invalid option. Please try again.'
      true
    end
  end
end
