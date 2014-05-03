require 'spec_helper'

module Battleship
  module Models
    module BoardLoader
      describe ConfigFileStrategy do
        describe '.apply' do
          let(:board) { Board.new }
          let(:options) { Hash.new }

          subject(:strategy) { ConfigFileStrategy.new options }

          context 'with default config file' do
            subject(:strategy) { ConfigFileStrategy.new }

            it 'load the ships correctly' do
              subject.apply board

              expect(board.send(:ships).length).to be 6
            end
          end

          context 'when with valid game config file' do
            let(:options) { {config_file: 'config/game.yml'} }

            it 'load the ships correctly' do
              subject.apply board

              expect(board.send(:ships).length).to be 6
            end
          end

          context 'when with invalid ship placement in game config file' do
            let(:options) {
              {config_file: 'spec/files/invalid_placement_game.yml'}
            }

            it {
              expect { subject.apply board }
                .to raise_exception(InvalidShipPlacementError)
            }
          end

          context 'when with invalid format in game config file' do
            let(:options) {
              {config_file: 'spec/files/invalid_format_game.yml'}
            }

            it {
              expect { subject.apply board }.to raise_exception
            }
          end
        end
      end
    end
  end
end
