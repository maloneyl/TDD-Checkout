class Item

  attr_accessor :code, :price_in_pence

  def initialize(attributes = {})
    @code = attributes[:code]
    @price_in_pence = attributes[:price_in_pence]
  end
end
