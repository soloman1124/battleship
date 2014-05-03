module Battleship
  module Models
    class AttackResult
      attr_reader :ship_destroyed, :position_status

      def initialize position_status, ship_destroyed = nil
        @position_status = position_status
        @ship_destroyed = ship_destroyed
      end

      def as_json *opt
        {
          position_status: position_status,
          ship_destroyed: ship_destroyed
        }
      end
    end
  end
end
