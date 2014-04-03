require 'rspec'
require_relative '../lib/discount_rule'

describe DiscountRule do
  let(:discount_rule) { DiscountRule.new(threshold: 6000, discount: 10) }

  describe '.new' do
    let(:items) { [double] }

    subject { discount_rule }

    it { should be_instance_of(DiscountRule) }
    its(:threshold) { should eql(6000) }
    its(:discount) { should eql(10) }
  end

  describe '#apply' do
    describe 'when total exceeds threshold' do
      let(:items) { [double(price_in_pence: 5000), double(price_in_pence: 1001)] }
      subject { discount_rule.apply(items) }

      it { should eql(600) }
    end

    describe 'when total does not exceed threshold' do
      let(:items) { [double(price_in_pence: 500), double(price_in_pence: 101)] }
      subject { discount_rule.apply(items) }

      it { should eql(0) }
    end
  end


end
