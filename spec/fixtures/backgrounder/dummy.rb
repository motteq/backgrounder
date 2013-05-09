class Backgrounder::Dummy
  include Backgrounder::Handler

  @queue = Backgrounder::Resque::Queue::High

  def id
    123
  end
end
