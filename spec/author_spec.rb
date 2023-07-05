require_relative '../author'
require_relative '../item'

describe Author do
  describe '#initialize' do
    it 'author must be created' do
      author = Author.new('Atif', 'Zada')

      expect(author.first_name).to eq('Atif')
      expect(author.last_name).to eq('Zada')
      expect(author.items).to be_empty
    end
  end
end
