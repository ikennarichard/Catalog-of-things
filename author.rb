class Author
  attr_reader :first_name, :last_name, :items, :id

  def initialize(first_name, last_name)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
    item.author = self
  end

  private

  def id
    Random.rand(1..1000)
  end
  def to_json(*_args)
    author = {
      'id' => @id,
      'first_name' => @first_name,
      'last_name' => @last_name,
      'items' => []
    }
    @items.each do |item|
      author['items'] << {
        'id' => item.id,
        'multiplayer' => item.multiplayer,
        'last_played_at' => item.last_played_at,
        'publish_date' => item.publish_date,
        'archived' => item.archived
      }
    end
    author.to_json
  end
end
