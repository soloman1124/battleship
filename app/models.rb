module Battleship
  module Models
    autoload :AttackResult, 'app/models/attack_result'
    autoload :Board, 'app/models/board'
    autoload :Bounds, 'app/models/bounds'
    autoload :Position, 'app/models/position'
    autoload :Ship, 'app/models/ship'
    autoload :ShipType, 'app/models/ship_type'
    autoload :BoardLoader, 'app/models/board_loader'

    class InvalidShipPlacementError < StandardError; end
    class InvalidShipTypeError < StandardError; end
    class InvalidAttackError < StandardError; end
  end
end
