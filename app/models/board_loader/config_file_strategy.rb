module Battleship
  module Models
    module BoardLoader
      class ConfigFileStrategy
        CONFIG_FILE = 'config/game.yml'

        def initialize options = {}
          @config_file = options.fetch :config_file, CONFIG_FILE
        end

        def apply board
          YAML.load_file(config_file).each do |ship_hash|
            position = Position.new *ship_hash[:position].values_at(:x, :y)

            board.place Ship.new(
              ship_hash.fetch(:ship_type), position, ship_hash.fetch(:direction)
            )
          end

          board
        end

        private

        attr_reader :config_file
      end
    end
  end
end
