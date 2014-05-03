require 'set'

module Battleship
  module Models
    class Board
      BOUNDS = Bounds.new 10, 10
      GAME_FILE = 'config/game.yml'

      def attack position
        raise InvalidAttackError unless bounds.cover? position
        attacked_positions << position
        status = position_status position

        if status == :ship_destroyed
          AttackResult.new status, ship_at(position)
        else
          AttackResult.new status
        end
      end

      def place ship
        raise InvalidShipPlacementError unless valid_placement? ship
        ship.instance_variable_set :@board, self
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
        attacked_positions.clear
      end

      def destroyed? ship
        (ship.occupied_positions - attacked_positions.to_a).empty?
      end

      def as_json *opt
        {
          bounds: bounds,
          positions_status: positions_status,
        }
      end

      private

      def attacked_positions
        @attacked_positions ||= Set.new
      end

      def positions_status
        @positions_status ||= Hash.new
      end

      def position_status position
        return unless attacked_positions.include? position

        positions_status.fetch position do
          ship = ship_at position
          positions_status[position] = if ship.nil?
            :missed
          elsif ship.destroyed?
            :ship_destroyed
          else
            :hit
          end
        end
      end

      def ship_at position
        ships.find do |ship|
          ship.occupied_positions.include? position
        end
      end

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
