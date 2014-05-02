module Battleship
  module Routes
    class Index < Base
      get '/' do
        erb :index
      end
    end
  end
end
