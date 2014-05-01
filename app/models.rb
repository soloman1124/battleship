module Battleship
  module Models
    autoload :AttackResult, 'app/models/attack_result'
    autoload :Board, 'app/models/board'
    autoload :Bounds, 'app/models/bounds'
    autoload :Position, 'app/models/position'
    autoload :Ship, 'app/models/ship'
    autoload :ShipType, 'app/models/ship_type'

    class InvalidShipPlacementError < StandardError; end
    class InvalidShipTypeError < StandardError; end
  end
end
