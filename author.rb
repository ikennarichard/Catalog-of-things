class Author
  attr_reader :first_name, :last_name, :items, :id

  def initialize(first_name, last_name)
    @id = create_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
  end

  private

  def create_id
    Random.rand(1..1000)
  end

  def to_json(_param)
    author = {
      'id' => @id,
      'first_name' => @first_name,
      'last_name' => @last_name,
      'items' => []
    }
    @items.each do |element|
      author['elements'] << {
        'id' => item.id,
        'multiplayer' => element.multiplayer,
        'last_played_at' => element.last_played_at,
        'publish_date' => element.publish_date,
        'archived' => element.archived
      }
    end
    author.to_json
  end
end
