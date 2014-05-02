module Battleship
  module Routes
    class Game < Base
      get '/game' do
        json board
      end

      post '/game/attack' do
        position = Position.new params[:x].to_i, params[:y].to_i

        json board.attack position
      end

      get '/game/reset' do
        session[:board] = nil

        json board.load
      end

      private

      def board
        session[:board] ||= Board.new.load
      end
    end
  end
end
