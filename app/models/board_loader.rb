require 'active_support'
require 'app/models/board_loader/random_strategy'
require 'app/models/board_loader/config_file_strategy'

module Battleship
  module Models
    module BoardLoader
      def self.new_board options = {}
        board = Board.new
        strategy(options).apply board

        board
      end

      def self.strategy options
        strategy_key = options.delete :strategy

        strategy_class(strategy_key).new options
      end

      def self.strategy_class strategy_key = :config_file
        "Battleship::Models::BoardLoader::#{strategy_key.to_s.classify}Strategy"
          .constantize
      rescue
        ConfigFileStrategy
      end
    end
  end
end
