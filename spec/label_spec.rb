require_relative '../label'
require_relative '../book'

describe Label do
  before(:each) do
    @book = Book.new('publisher', 'cover_state', '2022-09-09', archived: true)
    @label = Label.new('title', 'color')
    @label.add_item(@book)
  end

  it 'return a author object' do
    expect(@label).to be_an_instance_of(Label)
  end

  it 'return the correct title' do
    expect(@label.title).to eq('title')
  end

  it 'return the correct color' do
    expect(@label.color).to eq('color')
  end

  it 'adds a book to the items array' do
    expect(@label.items).to include(@book)
  end
end
