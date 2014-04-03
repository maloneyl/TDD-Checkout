require 'rspec'
require_relative '../lib/bulk_rule'
require_relative '../lib/item'

describe BulkRule do
  subject { BulkRule.new(code: '001', price_in_pence: 850, quantity: 2) }

  describe '.new' do
    it { should be_instance_of(BulkRule) }
    its(:code) { should eql('001') }
    its(:price_in_pence) { should eql(850) }
    its(:quantity) { should eql(2) }
  end

  describe '#apply' do
    # let(:bulk_rule) { BulkRule.new(code: '001', price_in_pence: 850, quantity: 2) }
    let(:item) { Item.new(code: '001', price_in_pence: 925) }
    let(:items) { [item.dup, item.dup] }

    describe 'when the items trigger a different price' do
      it 'should modify the price of the item' do
        subject.apply(items)
        expect(items.first.price_in_pence).to eql(850)
      end
    end
  end

end


