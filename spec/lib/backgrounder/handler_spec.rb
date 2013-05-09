require 'spec_helper'

describe Backgrounder::Handler do
  it "includes perform class method" do
    Backgrounder::Dummy.stub(:perform){ |arg1, arg2| true }
    Backgrounder::Dummy.perform(1, :dummy_method).should be_true
  end

  context "id is set" do
    it "calls method passed as second arg on object with ID passed as first arg" do
      Backgrounder::Dummy.stub(:find).with(1){ Backgrounder::Dummy.new }
      Backgrounder::Dummy.any_instance.stub(:dummy_method){ true }
      Backgrounder::Dummy.should_receive(:find).with(1)
      Backgrounder::Dummy.any_instance.should_receive(:dummy_method)
      Backgrounder::Dummy.perform(1, :dummy_method)
    end
  end

  context "id is nil" do
    it "calls class method passed as second arg" do
      Backgrounder::Dummy.stub(:dummy_method){ true }
      Backgrounder::Dummy.should_receive(:dummy_method)
      Backgrounder::Dummy.perform(nil, :dummy_method)
    end
  end

  context "id is 'new'" do
    it "calls method on new object" do
      Backgrounder::Dummy.any_instance.stub(:dummy_method){ true }
      Backgrounder::Dummy.any_instance.should_receive(:dummy_method)
      Backgrounder::Dummy.perform('new', :dummy_method)
    end

    it "initialize new object with init_args" do
      dummy = double('backgrounder_dummy')
      Backgrounder::Dummy.stub(:new).with({'foo' => 'bar', 'fuz' => 'buz'}).and_return{ dummy }
      dummy.should_receive(:dummy_method).once
      Backgrounder::Dummy.perform 'new', :dummy_method, {'init_args' => {'foo' => 'bar', 'fuz' => 'buz'}}
    end
  end
end
