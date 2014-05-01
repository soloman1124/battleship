require 'spec_helper'

module Battleship
  module Models
    describe Board do
      subject(:board) { Board.new }

      describe '#attack' do
      end

      describe '#place' do
        let(:ship_position) { Position.new 0, 0 }
        let(:ship) { Ship.new :battleship, ship_position, :horizontal }

        context 'when ship is inside of the board' do
          it { expect(subject.place ship).to be(subject) }
        end

        context 'when part of ship is outside of the board' do
          let(:ship_position) { Position.new 0, 8 }

          it {
            expect { subject.place ship }
              .to raise_exception(InvalidShipPlacementError)
          }
        end

        context 'when ship overlaps with other ships on the board' do
          before {
            another_ship = Ship.new :patrol_boat, Position.new(3, 3) , :vertical
            board.place another_ship
          }

          let(:ship_position) { Position.new 4, 2 }

          it {
            expect { subject.place ship }
              .to raise_exception(InvalidShipPlacementError)
          }
        end
      end

      describe '#load' do
        context 'when with valid game config file' do
          it { expect(subject.load).to be(subject) }
        end

        context 'when with invalid ship placement in game config file' do
          let(:invalid_placement_game) {
            'spec/files/invalid_placement_game.yml'
          }

          it {
            expect { subject.load invalid_placement_game }
              .to raise_exception(InvalidShipPlacementError)
          }
        end

        context 'when with invalid format in game config file' do
          let(:invalid_format_game) {
            'spec/files/invalid_format_game.yml'
          }

          it {
            expect { subject.load invalid_placement_game }.to raise_exception
          }
        end
      end
    end
  end
end
