class Label
  attr_accessor :id, :title, :color, :items

  def initialize(title, color)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.label = self
  end

  def to_h
    { 'title' => @title, 'color' => @color, 'items' => @items.map(&:to_h) }
  end
end
