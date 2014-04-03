require 'rspec'
require_relative '../lib/item'

describe Item do
  subject(:item){ Item.new(price_in_pence: 925, code: '001') }

  its(:code){ should eql('001') }
  its(:price_in_pence){ should eql(925) }

  context 'when modified' do
    before do
      item.code = '000'
      item.price_in_pence = 800
    end

    its(:code){ should eql('000') }
    its(:price_in_pence){ should eql(800) }
  end


end
