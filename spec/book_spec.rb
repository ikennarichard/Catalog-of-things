require_relative '../book'

describe Book do
  before(:each) do
    @book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', archived: true)
  end  

  it 'returns a book object' do
    expect(@book).to be_an_instance_of(Book)
  end

  it 'returns the correct publish_date' do
    expect(@book.publish_date).to eq('1925-04-10')
  end

  it 'returns the correct publisher name' do
    expect(@book.publisher).to eq('The Great Gatsby')
  end

  it 'returns the correct cover_state' do
    expect(@book.cover_state).to eq('F. Scott Fitzgerald')
  end

  it 'returns the correct archived status' do
    expect(@book.archived).to eq(true)
  end
end