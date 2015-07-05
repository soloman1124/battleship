require 'set'

module Battleship
  module Models
    class Board
      BOUNDS = Bounds.new 10, 10

      def attack position
        fail InvalidAttackError unless bounds.cover? position
        status = attack_and_update position

        if status == :ship_destroyed
          AttackResult.new status, ship_at(position)
        else
          AttackResult.new status
        end
      end

      def place ship
        fail InvalidShipPlacementError unless valid_placement? ship
        ship.instance_variable_set :@board, self
        ships << ship

        self
      end

      def reset
        attacked_positions.clear
        positions_status.clear
      end

      def destroyed? ship
        (ship.occupied_positions - attacked_positions.to_a).empty?
      end

      def as_json *_opt
        {
          bounds: bounds,
          positions_status: positions_status.map do |pos, status|
            { x: pos.x, y: pos.y, status: status }
          end
        }
      end

      private

      def attacked_positions
        @attacked_positions ||= Set.new
      end

      def positions_status
        @positions_status ||= Hash.new
      end

      def ship_attacked_status ship
        if ship.nil?
          :missed
        elsif ship.destroyed?
          :ship_destroyed
        else
          :hit
        end
      end

      # rubocop:disable Metrics/MethodLength
      def attack_and_update position
        attacked_positions << position
        ship = ship_at position
        status = ship_attacked_status ship

        if status == :ship_destroyed
          ship.occupied_positions.each do |pos|
            positions_status[pos] = :ship_destroyed
          end
        else
          positions_status[position] = status
        end

        status
      end
      # rubocop:enable Metrics/MethodLength

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
