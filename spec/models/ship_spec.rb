require 'spec_helper'

module Battleship
  module Models
    describe Ship do
      let(:ship_type) { :submarine }
      let(:position) { Position.new 2, 3 }
      let(:direction) { :vertical }
      let(:board) { Board.new }

      subject { Ship.new ship_type, position, direction }

      describe '#place_on' do
        context 'when placed correctly on the board' do
          it { expect(subject.place_on board).to be(subject) }
        end

        context 'when placed outside of the board' do
          let(:position) { Position.new 9, 10 }

          it {
            expect { subject.place_on board }
              .to raise_exception(InvalidShipPlacementError)
          }
        end
      end

      describe '#placed?' do
        context 'when not placed on the board' do
          it { expect(subject.placed?).to be_false }
        end

        context 'when after placed correctly on the board' do
          it 'returns true' do
            subject.place_on board

            expect(subject.placed?).to be_true
          end
        end

        context 'when after placed incorrectly on the board' do
          let(:position) { Position.new -1, -2 }

          it 'returns false' do
            begin
              subject.place_on board
            rescue InvalidShipPlacementError
            end

            expect(subject.placed?).to be_false
          end
        end
      end

      describe '#occupied_positions' do
        context 'with vertical direction' do
          let(:direction) { :vertical }

          its(:occupied_positions) {
            should == [
              Position.new(2, 3),
              Position.new(3, 3),
              Position.new(4, 3),
            ]
          }
        end

        context 'with horizontal direction' do
          let(:direction) { :horizontal }

          its(:occupied_positions) {
            should == [
              Position.new(2, 3),
              Position.new(2, 4),
              Position.new(2, 5),
            ]
          }
        end

        context 'with patrol boat ship type' do
          let(:ship_type) { :patrol_boat }

          its(:occupied_positions) {
            should == [
              Position.new(2, 3),
              Position.new(3, 3),
            ]
          }
        end

        context 'with position at x=1, y=2' do
          let(:position) { Position.new 1, 2 }

          its(:occupied_positions) {
            should == [
              Position.new(1, 2),
              Position.new(2, 2),
              Position.new(3, 2),
            ]
          }
        end
      end

      describe '#collide_with?' do
        let(:other_ship) { Ship.new :destroyer, Position.new(0, 0), :vertical }

        context 'when collide with another ship' do
          let(:position) { Position.new 0, 0 }

          it { expect(subject.collide_with? other_ship).to be_true }
        end

        context 'when not collide with another ship' do
          let(:position) { Position.new 0, 2 }

          it { expect(subject.collide_with? other_ship).to be_false }
        end
      end

      describe '#destroyed?' do
        before { subject.place_on board }

        context 'when all occupied positions are attacked' do
          before {
            subject.occupied_positions.each do |position|
              board.attack position
            end
          }

          it { expect(subject.destroyed?).to be_true }
        end

        context 'when some occupied positions are attacked' do
          before {
            board.attack subject.occupied_positions.first
          }

          it { expect(subject.destroyed?).to be_false }
        end

        context 'when none of occupied positions are attacked' do
          it { expect(subject.destroyed?).to be_false }
        end
      end
    end
  end
end
