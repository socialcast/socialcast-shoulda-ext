require File.expand_path("#{File.dirname(__FILE__)}/helper")

class TestTriggerCallbackMatcher < Test::Unit::TestCase
  
  context "doing nothing to a record" do
    subject { Blog.new :title => 'blog title' }
    should_not trigger_callbacks
  end
  
  context "creating a record" do
    subject { Blog.create! :title => 'blog title' }
    should trigger_callbacks.for :create
    should_not trigger_callbacks.for :update, :destroy
  end
  
  context "updating a record" do
    subject do
      Blog.create!( :title => 'blog title').tap do |b|
        b.reset_callback_flags!
        b.update_attribute :title, 'new blog title'
      end
    end
    should trigger_callbacks.for :update
    should_not trigger_callbacks.for :create, :destroy
  end
  
  context "destroying a record" do
    subject do
      Blog.create!( :title => 'blog title').tap do |b|
        b.reset_callback_flags!
        b.destroy
      end
    end
    should trigger_callbacks.for :destroy
    should_not trigger_callbacks.for :create, :update
  end
end
