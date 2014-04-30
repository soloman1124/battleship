require 'spec_helper'

module Battleship
  module Models
    describe Ship do
      let(:ship_type) { :submarine }
      let(:position) { Position.new 2, 3 }
      let(:direction) { :vertical }

      subject { Ship.new ship_type, position, direction }

      describe '#placed?' do
        context 'when not placed on the board' do
          it { expect(subject.placed?).to be_false }
        end

        context 'when after placed correctly on the board' do
          it 'returns true'
        end

        context 'when after placed incorrectly on the board' do
          it 'returns false'
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
    end
  end
end
