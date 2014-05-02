module Battleship
  module Models
    class AttackResult
      attr_reader :attacked_ship

      def initialize attacked_ship
        @attacked_ship = attacked_ship
      end

      def missed?
        attacked_ship.nil?
      end

      def ship_destroyed?
        attacked_ship.try :destroyed?
      end

      def as_json *opt
        {
          attacked_ship: attacked_ship,
          missed: missed?,
          ship_destroyed: ship_destroyed?
        }
      end
    end
  end
end
