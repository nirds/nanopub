require './app'

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

use Rack::ConditionalGet
use Rack::ETag

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('./', ::File.dirname(__FILE__))

require 'nesta/app'

run Rack::URLMap.new("/" => Sinatra::Application, "/blog" => Nesta::App)