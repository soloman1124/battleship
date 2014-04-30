module Battleship
  module Models
    autoload :Board, 'app/models/board'
    autoload :Ship, 'app/models/ship'
    autoload :ShipType, 'app/models/ship_type'
    autoload :Position, 'app/models/position'

    class InvalidShipTypeError < StandardError; end
  end
end
