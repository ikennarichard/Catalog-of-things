module BookLabelUtils
  def list_books
    @books = if File.exist?('./data/books.json')
               begin
                 JSON.parse(File.read('./data/books.json'))
               rescue StandardError
                 []
               end
             else
               []
             end

    if @books.empty?
      puts 'No books found'
    else
      puts 'List of Books:'
      @books.each_with_index do |book, index|
        puts "#{index + 1} Publisher: #{book['publisher']}, " \
             "Cover State: #{book['cover_state']}, " \
             "Publish Date: #{book['publish_date']}"
      end
    end
  end

  def list_labels
    @labels = if File.exist?('./data/labels.json')
                begin
                  JSON.parse(File.read('./data/labels.json'))
                rescue StandardError
                  []
                end
              else
                []
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
    @books = retrieve_books
    publisher = get_user_input('Enter publisher: ')
    cover_state = get_user_input('Enter cover state: ')
    publish_date_str = get_user_input('Enter publish date (yyyy-mm-dd): ')
    publish_date = parse_date(publish_date_str)
    return puts 'Invalid input. Book not added.' if invalid_input?(publisher, cover_state, publish_date)

    book = create_book(publisher, cover_state, publish_date)
    add_book_to_collection(book)
    save_books
    puts 'Book added successfully!'
  end

  def retrieve_books
    File.exist?('./data/books.json') ? JSON.parse(File.read('./data/books.json')) : []
  end

  def get_user_input(prompt)
    print prompt
    gets.chomp
  end

  def parse_date(date_str)
    Date.parse(date_str)
  rescue StandardError
    nil
  end

  def invalid_input?(publisher, cover_state, publish_date)
    publisher.empty? || cover_state.empty? || publish_date.nil?
  end

  def create_book(publisher, cover_state, publish_date)
    Book.new(publisher, cover_state, publish_date&.to_s || '')
  end

  def add_book_to_collection(book)
    @books << { 'publisher' => book.publisher, 'cover_state' => book.cover_state, 'publish_date' => book.publish_date }
  end

  def save_books
    File.write('./data/books.json', JSON.generate(@books))
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
