require 'rubygems'
require 'bundler'

# Setup load paths
Bundler.require
$LOAD_PATH << File.expand_path('../', __FILE__)
$LOAD_PATH << File.expand_path('../lib', __FILE__)

require 'dotenv'
Dotenv.load

# Require base
require 'sinatra/base'
require 'active_support/core_ext/string'
require 'active_support/core_ext/array'
require 'active_support/core_ext/hash'
require 'active_support/json'

libraries = Dir[File.expand_path('../lib/**/*.rb', __FILE__)]
libraries.each do |path_name|
  require path_name
end

require 'app/extensions'
require 'app/models'
require 'app/helpers'
require 'app/routes'

module Battleship
  class App < Sinatra::Application
    configure do
      disable :method_override
      disable :static

      set :erb, escape_html: true
    end

    use Rack::Deflater
    use Rack::Standards

    use Routes::Static

    use Rack::Session::Cookie, key: 'rack.session'

    use Routes::Assets unless settings.production?

    use Routes::Game
    use Routes::Index
  end
end

include Battleship::Models
