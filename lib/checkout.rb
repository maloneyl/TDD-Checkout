class Checkout

  attr_reader :rules, :items

  def initialize(promotional_rules = [])
    @rules = promotional_rules
    @items = []
  end

  def scan(item)
    @items << item.dup
    true
  end

  def total
    current_discount = discount
    total = subtotal - current_discount
    sprintf("£%.2f", total/100.00) # forces to 2dp
  end

  def subtotal
    @items.inject(0) { |sum, item| sum += item.price_in_pence }
  end

  def discount
    # @rules.inject(0) do |sum, rule|
    #   discounted_amount_or_nothing = rule.apply(@items)
    #   if discounted_amount_or_nothing.respond_to?(:+) # duck typing
    #     sum + discounted_amount_or_nothing
    #   else
    #     sum
    #   end
    # end
    @rules.inject(0) { |sum, rule| sum += rule.apply(@items) }
  end

end
