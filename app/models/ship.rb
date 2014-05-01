module Battleship
  module Models
    class Ship
      attr_reader :type, :position, :direction

      def initialize type_key, position, direction
        @type = ShipType.find type_key
        @position = position
        @direction = direction
      end

      def occupied_positions
        @occupied_positions ||= (0...type.size).map do |distance|
          position.move distance, direction
        end
      end

      def place_on board
        @board ||= board.place self

        self
      end

      def placed?
        @board
      end

      def collide_with? other_ship
        (occupied_positions & other_ship.occupied_positions).any?
      end
    end
  end
end
