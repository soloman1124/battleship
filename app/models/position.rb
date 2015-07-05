module Battleship
  module Models
    class Position
      attr_reader :x, :y

      def initialize x, y
        @x = x
        @y = y
      end

      def move distance, direction = :vertical
        if direction == :vertical
          Position.new x + distance, y
        elsif direction == :horizontal
          Position.new x, y + distance
        else
          fail ArgumentError
        end
      end

      def ==(other)
        self.class == other.class && x == other.x && y == other.y
      end
      alias_method :eql?, :==

      def hash
        [x, y].hash
      end

      def to_s
        "(#{x}, #{y})"
      end
    end
  end
end
