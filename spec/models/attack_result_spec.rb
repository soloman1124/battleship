require 'spec_helper'

module Battleship
  module Models
    describe AttackResult do
      context 'when attack missed' do
        subject(:result) { AttackResult.new nil }

        its(:missed?) { should be_true }
        its(:attacked_ship) { should be_nil }
        its(:ship_destroyed?) { should be_false }
      end

      context 'when attack hit' do
        let(:ship) { double Ship }

        subject(:result) { AttackResult.new ship }

        its(:missed?) { should be_false }
        its(:attacked_ship) { should be(ship) }
        its(:ship_destroyed?) { should be_false }
      end

      context 'when attack destroyed a ship' do
        let(:ship) {
          double Ship, :destroyed? => true
        }

        subject(:result) {
          AttackResult.new ship
        }

        its(:missed?) { should be_false }
        its(:attacked_ship) { should be(ship) }
        its(:ship_destroyed?) { should be_true }
      end
    end
  end
end
