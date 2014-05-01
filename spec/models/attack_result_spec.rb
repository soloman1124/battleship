require 'spec_helper'

module Battleship
  module Models
    describe AttackResult do
      context 'when attack missed' do
        subject(:result) { AttackResult.new nil }

        its(:missed?) { should be_true }
        its(:attacked_ship) { should be_nil }
      end

      context 'when attack hit' do
        let(:ship) { Ship.new :destroyer, Position.new(0, 0), :vertical }

        subject(:result) {
          AttackResult.new ship
        }

        its(:missed?) { should be_false }
        its(:attacked_ship) { should be(ship) }
      end
    end
  end
end
