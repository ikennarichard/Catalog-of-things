require 'date'

class Item
  attr_reader :id, :archived
  attr_accessor :publish_date, :genre, :author, :source, :label

  def initialize(publish_date)
    @id = Random.rand(0..1000)
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    Time.now.year - Date.parse(publish_date).year > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
