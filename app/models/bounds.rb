module Battleship
  module Models
    class Bounds
      def initialize width, height
        @width = width
        @height = height
      end

      def cover? *positions
        positions.flatten.all? do |position|
          position.x >= 0 && position.y >= 0 &&
            position.x < width && position.y < height
        end
      end

      private

      attr_reader :width, :height
    end
  end
end
