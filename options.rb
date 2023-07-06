
require_relative 'app'
class Options
  def display_options
    puts 'Choose an option:'
    puts '1. List all books'
    puts '2. List all music albums'
    puts '3. List all games'
    puts '4. List all genres'
    puts '5. List labels'
    puts '6. List all authors'
    puts '7. Add a book'
    puts '8. Add a label'
    puts '9. Add a music albums'
    puts '10. Add a game'
    puts '11. Quit'
  end

  def process_option(app, option)
    actions = {
      1 => -> { app.list_books },
      2 => -> { app.list_music_albums },
      3 => -> { app.display_games },
      4 => -> { app.list_all_genres },
      5 => -> { app.list_labels },
      6 => -> { app.display_authors },
      7 => -> { app.add_book },
      8 => -> { app.add_label },
      9 => -> { app.add_music_album },
      10 => -> { app.create_game },
      11 => -> { puts 'Exiting the app...‍🚀' }
    }
    action = actions[option]
    if action
      action.call
      option != 11
    else
      puts 'Invalid option. Please try again.'
      true
    end
  end
  
end
