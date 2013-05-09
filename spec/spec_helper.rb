$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'bundler/setup'
require 'resque_spec'

Bundler.require

Dir["#{File.dirname(__FILE__)}/fixtures/**/*.rb"].each{|f| require f}

RSpec.configure do |config|
  config.order = "random"
end
