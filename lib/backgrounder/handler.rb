module Backgrounder::Handler
  extend ActiveSupport::Concern

  module ClassMethods
    def perform(id, action, *args)
      case id
      when 'new'
        obj = if args.any? && args.first.is_a?(Hash) && args.first['init_args']
          new args.first['init_args']
        else
          new
        end
        obj.send action
      when nil
        send action
      else
        find(id).send(action)
      end
    end
  end
end
