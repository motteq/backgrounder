class Backgrounder::Placer
  def initialize(obj, method_name, opts = {})
    if obj.class == Class
      @klass = obj
      @obj_id = opts[:args] && opts[:args][:init_args] ? 'new' : nil
    else
      @klass = obj.class
      @obj_id = fetch_id obj
    end
    @method_name = method_name
    @queue = opts[:queue] ? opts[:queue] : fetch_queue_name
    @args = opts[:args] ? opts[:args] : nil
  end

  def place
    Resque::Job.create @queue, @klass, @obj_id, @method_name, @args
  end


  private

    def fetch_queue_name
      @klass.instance_variable_get "@queue"
    end

    def fetch_id obj
      if obj.respond_to? :id
        obj.id ? obj.id : 'new'
      else
        'new'
      end
    end
end
