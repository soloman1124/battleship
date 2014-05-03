require 'spec_helper'

module Battleship
  module Models
    describe BoardLoader do
      describe '.strategy_class' do
        context 'when with invalid strategy key' do
          it {
            expect(BoardLoader.strategy_class :unknown)
              .to be Battleship::Models::BoardLoader::ConfigFileStrategy
          }
        end

        context 'when with valid strategy key' do
          it {
            expect(BoardLoader.strategy_class :random)
              .to be(Battleship::Models::BoardLoader::RandomStrategy)
          }
        end
      end
    end
  end
end
