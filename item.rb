require 'date'

class Item
  attr_reader :id,
  attr_accessor :publish_date, :genre, :author, :source, :label, :archived

  def initializer(publish_date, archived: false)
    @id = Random.rand(0...1000)
    @publish_date = Date.parse(publish_date)
    @archived = archived
  end

  def can_be_archived?
    Time.now.year - publish_date.year > 10
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end
end
