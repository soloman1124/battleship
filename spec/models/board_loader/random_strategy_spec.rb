require 'spec_helper'

module Battleship
  module Models
    module BoardLoader
      describe RandomStrategy do
        let(:board) { Board.new }

        subject(:strategy) { RandomStrategy.new }

        describe '.apply' do
          before { subject.apply board }

          it { expect(board.send(:ships).size).to be > 1 }

          it 'generate different boards in different runs' do
            results = 10.times.map do
              board = Board.new
              subject.apply board

              (0...100).map do |v|
                position = Position.new *v.divmod(10)

                board.attack(position).position_status
              end
            end

            expect(results.uniq.size).to_not be 1
          end
        end
      end
    end
  end
end
