require 'rspec'
require_relative '../lib/checkout'
require_relative '../lib/item'
require_relative '../lib/discount_rule'
require_relative '../lib/bulk_rule'

describe Checkout do
  describe '.new' do # dot for class methods
    describe 'with no arguments' do
      subject { Checkout.new } # 'it' that follows will now refer to this subject

      # it { should be_kind_of Checkout }
      it { should be_instance_of Checkout }
    end

    describe 'with an array of promotional rules' do
      let(:rules) { [double] } # double is a method that gives you a stand-in object

      subject { Checkout.new(rules) }

      it { should be_instance_of Checkout }
      its(:rules) { should_not be_empty }
    end
  end

  describe '#scan' do # hash for instance methods
    let(:checkout) { Checkout.new }
    let(:item) { Item.new }

    subject(:scan_item) { checkout.scan(item) }
    it { should eql(true) }
    it 'should store the item' do
      scan_item
      expect(checkout.items.length).to eql(1)
    end

    describe 'with 2 of the same item' do
      it 'should keep each item as its own entity' do
        checkout.scan(item)
        checkout.scan(item)
        expect(checkout.items.length).to eql(2)
        expect(checkout.items.first).not_to eql(checkout.items.last)
      end
    end
  end

  describe '#total' do
    let(:checkout) { Checkout.new }
    let(:lavender_heart) { Item.new code: '001', name: 'Lavender Heart', price_in_pence: 925 }
    let(:personalised_cufflinks) { Item.new code: '002', name: 'Personalised Cufflinks', price_in_pence: 4500 }
    let(:kids_t_shirt) { Item.new code: '003', name: 'Kids T-shirt', price_in_pence: 1995 }

    describe 'with 2 different items that will not trigger the discount' do
      before do
        checkout.scan(lavender_heart)
        checkout.scan(personalised_cufflinks)
      end

      subject { checkout.total }

      it { should eql('£54.25') }
    end

    describe 'with enough items to activate discount' do
      let(:discount_rule) { DiscountRule.new(threshold: 6000, discount: 10) }
      let(:checkout) { Checkout.new([discount_rule]) }

      before do
        checkout.scan(lavender_heart)
        checkout.scan(personalised_cufflinks)
        checkout.scan(kids_t_shirt)
      end

      subject { checkout.total }

      it { should eql('£66.78') }
    end

    describe 'with 2 or more lavender hearts to trigger the bulk discount' do
      let(:bulk_rule) { BulkRule.new(code: '001', price_in_pence: 850, quantity: 2) }
      let(:checkout) { Checkout.new([bulk_rule]) }

      before do
        checkout.scan(lavender_heart)
        checkout.scan(lavender_heart)
        checkout.scan(kids_t_shirt)
      end

      subject { checkout.total }

      it { should eql('£36.95') }
    end

    describe 'with enough items to trigger both the lavender-heart bulk discount and the over-£60 discount' do
      let(:discount_rule) { DiscountRule.new(threshold: 6000, discount: 10) }
      let(:bulk_rule) { BulkRule.new(code: '001', price_in_pence: 850, quantity: 2) }
      let(:checkout) { Checkout.new([bulk_rule, discount_rule]) }

      before do
        checkout.scan(lavender_heart)
        checkout.scan(lavender_heart)
        checkout.scan(kids_t_shirt)
        checkout.scan(personalised_cufflinks)
      end

      subject { checkout.total }

      it { should eql('£73.76') }
    end
  end
end
