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
    item.author = self
  end

  private

  def create_id
    Random.rand(1..1000)
  end
end
