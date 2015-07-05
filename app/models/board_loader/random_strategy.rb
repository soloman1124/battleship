module Battleship
  module Models
    module BoardLoader
      class RandomStrategy
        def initialize options = {}
          @max_num_trials = options.fetch :max_num_trials, 100
          @max_num_ships = options.fetch :max_num_ships, 7
        end

        def apply board
          ship_count = 0
          max_num_trials.times do
            ship = random_ship board
            ship_count += 1 if ship

            break if ship_count >= max_num_ships
          end
        end

        private

        attr_reader :max_num_ships, :max_num_trials

        def random_ship board
          type = ShipType.all.keys.sample
          position = Position.new(*(0...100).to_a.sample.divmod(10))
          direction = [:vertial, :horizontal].sample

          Ship.new(type, position, direction).place_on board
        rescue
          nil
        end
      end
    end
  end
end
