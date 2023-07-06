require_relative 'item'

class Book < Item
  attr_reader :publish_date, :publisher, :cover_state, :archived

  def initialize(publisher, cover_state, publish_date, archived: false)
    super(publish_date, archived: archived)
    @publisher = publisher
    @cover_state = cover_state
  end

  private

  def can_be_archived?
    super || cover_state.downcase == 'bad'
  end
end
