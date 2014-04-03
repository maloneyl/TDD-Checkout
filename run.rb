require_relative 'lib/checkout'
require_relative 'lib/bulk_rule'
require_relative 'lib/discount_rule'
require_relative 'lib/item'

rule = BulkRule.new(code: '001', price_in_pence: 850, quantity: 2)

c = Checkout.new([rule])
lavender = Item.new(code: '001', price_in_pence: 925)
c.scan lavender
c.scan lavender

puts c.items.inspect

puts c.total
