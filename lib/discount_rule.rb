class DiscountRule

  attr_reader :threshold, :discount

  def initialize(threshold: 0, discount: 0) # with Ruby 2, you can do initialize(threshold:, discount:)
    @threshold = threshold
    @discount = discount
  end

  def apply(items)
    total = items.inject(0) { |sum, item| sum += item.price_in_pence }
    if total > @threshold
      total * @discount/100 # we want to display discount amount
    else
      0
    end
  end

end
