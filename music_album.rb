require_relative 'item'
require_relative 'genre'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(title, on_spotify: false)
    super()
    @title = title
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super and on_spotify
  end
end
