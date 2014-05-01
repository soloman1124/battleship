module Battleship
  module Models
    class Board
      BOUNDS = Bounds.new 10, 10
      GAME_FILE = 'config/game.yml'

      def place ship
        raise InvalidShipPlacementError unless valid_placement? ship
        ships << ship

        self
      end

      def load game_file = GAME_FILE
        reset
        YAML.load_file(game_file).each do |ship_hash|
          position = Position.new *ship_hash[:position].values_at(:x, :y)

          place Ship.new(
            ship_hash.fetch(:ship_type), position, ship_hash.fetch(:direction)
          )
        end

        self
      end

      def reset
        ships.clear
      end

      private

      def ships
        @ships ||= []
      end

      def bounds
        BOUNDS
      end

      def valid_placement? ship
        inside_board?(ship) && !collide_others?(ship)
      end

      def inside_board? ship
        bounds.cover? ship.occupied_positions
      end

      def collide_others? ship
        ships.any? do |other_ship|
          other_ship.collide_with? ship
        end
      end
    end
  end
end
