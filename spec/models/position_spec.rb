require 'spec_helper'

module Battleship
  module Models
    describe Position do
      subject { Position.new 2, 4 }

      its(:x) { should == 2 }
      its(:y) { should == 4 }

      it { should == Position.new(2, 4) }
      it { should_not == Position.new(2, 5) }

      context 'with a list of positions' do
        subject { [Position.new(1, 2), Position.new(3, 4)] }

        it { expect(subject).to include Position.new(3, 4) }

        it { expect(subject).to_not include Position.new(3, 5) }
      end

      describe '#move' do
        let(:distance) { 3 }

        context 'with vertical direction' do
          it {
            expect(subject.move(distance, :vertical)).to eq Position.new(5, 4)
          }
        end

        context 'with horizontal direction' do
          it {
            expect(subject.move(distance, :horizontal)).to eq Position.new(2, 7)
          }
        end

        context 'with invalid direction key' do
          it {
            expect {
              subject.move(distance, :invalid)
            }.to raise_exception ArgumentError
          }
        end
      end
    end
  end
end
