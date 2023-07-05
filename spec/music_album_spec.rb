require_relative '../music-album'
require_relative '../genre'

describe MusicAlbum do
  let(:music_album) { MusicAlbum.new 'Go web' }
  let(:genre) { Genre.new('Space') }

  describe '#initialize' do
    it 'should set on_spotify to false when initialized' do
      expect(music_album.on_spotify).to eq(false)
    end
  end

  describe '#can_be_archived?' do
    context 'when super method returns true and on_spotify is true' do
      it 'should return true' do
        music_album.publish_date = Date.parse('2010/04/07')
        music_album.on_spotify = true
        expect(music_album.can_be_archived?).to eq(true)
      end
    end
  end
end
