# require_relative 'items'
require_relative '../genre'
require_relative '../item'

describe Genre do
  let(:genre) { Genre.new('Comedy') }
  let(:item) { Item.new false }

  describe '#initialize' do
    it 'should set a random id' do
      expect(genre.instance_variable_get(:@id)).to be_between(1, 999)
    end

    it 'should set the name' do
      expect(genre.name).to eq('Comedy')
    end

    it 'should set items to empty array' do
      expect(genre.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'adds an item to the genre' do
      genre.add_item(item)

      expect(genre.items).to include(item)
      expect(item.genre).to eq(genre)
    end
  end
end
