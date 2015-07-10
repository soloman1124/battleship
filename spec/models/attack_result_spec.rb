require 'spec_helper'

module Battleship
  module Models
    describe AttackResult do
      let(:ship) { double(Ship) }

      subject(:result) { AttackResult.new :missed, ship }

      its(:position_status) { should be :missedx }
      its(:ship_destroyed) { should be ship }
    end
  end
end
