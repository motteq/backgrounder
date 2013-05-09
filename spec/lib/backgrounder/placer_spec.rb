require 'spec_helper'

describe Backgrounder::Placer do
  describe "instance methods" do
    describe "#initialize" do
      it "can get 3 parameters" do
        Backgrounder::Placer.new(Backgrounder::Dummy.new, :dummy_method, queue: :processing).
          should be_instance_of(Backgrounder::Placer)
      end
    end

    describe "#place" do
      it "adds dummy_method to the processing queue of Backgrounder::Dummy" do
        Backgrounder::Placer.new(Backgrounder::Dummy.new, :dummy_method, queue: :processing).place
        Backgrounder::Dummy.should have_queued(123, :dummy_method, nil).in(:processing)
      end

      it "adds dummy_method to the default queue of Backgrounder::Dummy" do
        Backgrounder::Placer.new(Backgrounder::Dummy.new, :dummy_method).place
        Backgrounder::Dummy.should have_queued(123, :dummy_method, nil).in(:high)
      end

      it "adds nil as first arg of queue if placer works on class" do
        Backgrounder::Placer.new(Backgrounder::Dummy, :dummy_method).place
        Backgrounder::Dummy.should have_queued(nil, :dummy_method, nil)
      end

      it "adds args to queue" do
        Backgrounder::Placer.new(Backgrounder::Dummy.new, :dummy_method, args: {'foo' => {'bar' => 'baz'}}).place
        Backgrounder::Dummy.should have_queued(123, :dummy_method, {'foo' => {'bar' => 'baz'}})
      end

      it "adds new as first arg if object's ID is nil" do
        obj = Backgrounder::Dummy.new
        obj.stub(:id){ nil }
        Backgrounder::Placer.new(obj, :dummy_method).place
        Backgrounder::Dummy.should have_queued('new', :dummy_method, nil)
      end

      it "adds new as first arg if object does not respond to id" do
        obj = Backgrounder::Dummy.new
        obj.stub(:id){ raise NoMethodError, 'undefined method id' }
        obj.stub(:respond_to?).with(:id).and_return{ false }
        Backgrounder::Placer.new(obj, :dummy_method).place
        Backgrounder::Dummy.should have_queued('new', :dummy_method, nil)
      end

      it "adds new as first arg if placer works on class and init_args are passed" do
        Backgrounder::Placer.new(Backgrounder::Dummy, :dummy_method, args: {init_args: {'foo' => 'bar'}}).place
        Backgrounder::Dummy.should have_queued('new', :dummy_method, {init_args: {'foo' => 'bar'}})
      end
    end
  end
end
