module Backgrounder
end

require 'active_support/concern' unless defined?(ActiveSupport::Concern)
require 'resque'

require "backgrounder/version"
require "backgrounder/handler"
require "backgrounder/placer"
require "backgrounder/resque/queue"