require_relative 'app'

class Options
  def display_options
    puts 'Choose an option:'
    puts '1. List all genres'
    puts '2. Create an album'
    puts '3. List all music albums'
    puts '4. Quit'
  end

  def process_option(app, option)
    actions = {
      1 => -> { app.list_all_genres },
      2 => -> { app.add_music_album },
      3 => -> { app.list_music_albums },
      4 => -> { puts 'Exiting the app...‍🚀' }
    }

    action = actions[option]
    if action
      action.call
      option != 4
    else
      puts 'Invalid option. Please try again.'
      true
    end
  end
end
