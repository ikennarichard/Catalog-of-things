require_relative 'options'

def main
  options = Options.new

  loop do
    options.display_options
    option = gets.chomp.to_i
    break unless options.process_option(option)
  end
end

main
