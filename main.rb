require_relative 'options'
require_relative 'app'

def main
  options = Options.new
  app = App.new

  loop do
    options.display_options
    option = gets.chomp.to_i
    break unless options.process_option(app, option)
  end
end

main
