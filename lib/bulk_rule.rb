class BulkRule

  attr_reader :code, :price_in_pence, :quantity

  def initialize(code: '', price_in_pence: 0, quantity: 0)
    @code = code
    @price_in_pence = price_in_pence
    @quantity = quantity
  end

  def apply(items)
    bulk_items = items.select { |item| item.code == @code } # returns hash
    if bulk_items.length >= @quantity
      bulk_items.each { |item| item.price_in_pence = @price_in_pence }
    end
    # nil # if going the discounted_amount_or_nothing route
    0
  end

end
