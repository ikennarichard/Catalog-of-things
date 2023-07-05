require_relative 'item'
require_relative 'genre'

class MusicAlbum < Item
  attr_accessor :on_spotify, :genres, :publish_date

  def initialize(title, publish_date, on_spotify:false)
    super()
    @on_spotify = on_spotify
    @title = title
    @genres = []
    @publish_date = publish_date
  end

  def can_be_archived?
    super and on_spotify
  end

  def add_genre(genre)
    genre = Genre.new(genre)
    @genres << genre
    genre.add_item(self)
    genre
  end
end
