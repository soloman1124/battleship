require 'spec_helper'

module Battleship
  module Models
    describe Board do
      describe '#attack' do
        subject(:board) { BoardLoader.new_board }

        context 'when attack ouside of the board' do
          let(:position) { Position.new -1, -2 }

          it {
            expect { subject.attack position }
              .to raise_exception(InvalidAttackError)
          }
        end

        context 'when attack missed' do
          let(:position) { Position.new 0, 0 }

          it { expect(subject.attack(position).position_status).to be :not_missed }

          it { expect(subject.attack(position).ship_destroyed).to be_nil }
        end

        context 'when attack hit part of a ship' do
          let(:position) { Position.new 2, 1 }

          it { expect(subject.attack(position).position_status).to be :hit }

          it { expect(subject.attack(position).ship_destroyed).to be_nil }
        end

        context 'when attack destroyed entire ship' do
          before { subject.attack Position.new(1, 8) }

          let(:position) { Position.new 2, 8 }

          it {
            expect(subject.attack(position).position_status)
              .to be :ship_destroyed
          }

          it { expect(subject.attack(position).ship_destroyed).to_not be_nil }
        end
      end

      describe '#place' do
        subject(:board) { Board.new }

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
    end
  end
end
