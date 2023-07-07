require 'json'
require_relative 'book'
require_relative 'label'
require_relative 'genre'
require_relative 'music_album'
require_relative 'game'
require_relative 'author'
require_relative 'music_album_utils'
require_relative 'game_utils'
require_relative 'book_label_utils'

class App
  include MusicAlbumUtils
  include GameUtils
  include BookLabelUtils
  attr_accessor :books, :music_albums, :games

  def initialize
    @books = []
    @music_albums = []
    @games = []
    @authors = []
    retrieve_data
  end
end
