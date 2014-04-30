require 'spec_helper'

module Battleship
  module Models
    describe ShipType do
      describe '.find' do
        context 'with unknown type key' do
          it 'raises InvalidShipTypeError' do
            expect {
              ShipType.find :unknown
            }.to raise_exception InvalidShipTypeError
          end
        end

        context 'with configured type key' do
          it 'returns a ship type' do
            expect(
              ShipType.find :aircraft_carrier
            ).to be_a ShipType
          end
        end
      end

      subject { ShipType.find :battleship }

      its(:name) { should == 'Battleship' }
      its(:size) { should == 4}
    end
  end
end
