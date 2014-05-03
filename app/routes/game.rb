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
        json board.reset
      end


      get '/game/random' do
        session[:board] = nil

        json board :random
      end

      private

      def board strategy = nil
        session[:board] ||= BoardLoader.new_board strategy: strategy
      end
    end
  end
end
