module Battleship
  module Models
    class ShipType
      CONFIG_FILE = 'config/ship_type.yml'

      attr_reader :name, :size

      def initialize name, size
        @name = name
        @size = size
      end

      def self.find key
        all[key] || fail(InvalidShipTypeError)
      end

      def self.all
        @all ||=
          YAML
          .load_file(CONFIG_FILE)
          .each_with_object({}) do |(key, type), hash|
            hash[key] = new(*type.values_at(:name, :size))
          end
      end
    end
  end
end
