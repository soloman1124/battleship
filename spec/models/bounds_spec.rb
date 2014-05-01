require 'spec_helper'

module Battleship
  module Models
    describe Bounds do
      subject(:bounds) { Bounds.new 10, 5 }

      describe '#cover?' do
        out_of_bounds_positions =
          [[-1, 0], [0, -1], [9, 5], [10, 4]].map { |x, y| Position.new x, y }

        out_of_bounds_positions.each do |position|
          context "when outside of bounds position #{position}" do
            it { expect(subject.cover? position).to be_false }
          end
        end

        inside_of_bounds_positions =
          [[0, 0], [0, 4], [9, 0], [9, 4]].map { |x, y| Position.new x, y }

        inside_of_bounds_positions.each do |position|
          context "when inside of bounds position #{position}" do
            it { expect(subject.cover? position).to be_true }
          end
        end

        context 'with all out of bounds positions' do
          it { expect(subject.cover? out_of_bounds_positions).to be_false }
        end

        context 'with all inside of bounds positions' do
          it { expect(subject.cover? inside_of_bounds_positions).to be_true }
        end

        context 'with partial inside of bounds positions' do
          let(:positions) { [Position.new(3, 3), Position.new(-1, -1)] }

          it { expect(subject.cover? positions).to be_false }
        end
      end
    end
  end
end
