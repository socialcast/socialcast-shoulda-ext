module ShouldaExt # :nodoc:
  module Matchers # :nodoc:
    
    CALLBACK_EVENTS = [:before, :after, :after_commit_on]
    CALLBACK_TYPES = [:create, :update, :destroy, :save]
    
    # 
    # Examples
    # 
    #
    def trigger_callbacks
      TriggerCallbackMatcher.new.any
    end
  
    class TriggerCallbackMatcher # :nodoc:
      module ActiveRecordHooks 
        def self.included(base)
          base.class_eval do
            def self.inherited(sublcass)
              subclass.class_eval do
                class << self
                  attr_accessor :callback_tester_attrs
                end
                @callback_tester_attrs = []
                CALLBACK_EVENTS.each do |ce|
                  CALLBACK_TYPES.each do |ct|
                    callback_name = :"#{ce}_#{ct}"
                    callback_attr = :"called_#{callback_name}"
                    callback_method, has_on_option = (ce.to_s =~ /_on/ ? [ce.to_s.gsub('_on',''), true] : [callback_name, false]) 
                    @callback_tester_attrs << callback_attr
                    attr_accessor callback_attr
                    send( callback_method, (has_on_option ? {:on => ct} : {})) {
                      instance_variable_set(:"@#{callback_attr}", true)
                    }

                    define_method :"#{callback_attr}?" do
                      instance_variable_get(:"@#{callback_attr}")
                    end
                  end # - each
                end  # - each
              end # - class_eval
            end # - def self.inherited
            alias_method_chain :initialize, :callback_init
          end # - class_eval 
        end
        
        def initialize_with_callback_init(*args)
          reset_callback_flags!
          initialize_without_callback_init(*args)
        end

        def reset_callback_flags!
          self.class.callback_tester_attrs.each do |attr|
            send("#{attr}=", false)
          end
        end
        
      end # - ActiveRecordHooks
  
      # Define the set of callback types (create, update, destroy, save) to test
      def for(callback_types)
        @callback_types = Array.wrap(callback_types)
        @any_callbacks = false
        self
      end
  
      # Check to see if any of the callback types have been triggered
      def any
        @callback_types = CALLBACK_TYPES
        @any_callbacks = true
        self
      end
  
      def failure_message
        "Expected #{@subject} #{expectation}:"
      end
  
      def negative_failure_message
        "Did not expect #{@subject} #{expectation}:"
      end
  
      def description
        "check that #{@callback_types.join(', ')} callbacks were called"
      end
  
      def expectation
        @expectations.join("\n")
      end
  
      def matches?(subject)
        @subject = subject
        @expectations = []
        result = !@any_callbacks
        @callback_types.each do |ct|
          CALLBACK_EVENTS.each do |ce|
            called = @subject.send(:"called_#{ce}_#{ct}?")
            if @any_callbacks
              result ||= called
            else
              result &&= called
            end
            @expectations << "#{ce}_#{ct} callbacks to be triggered"
          end
        end
        result
      end
    end # - TriggerCallbackMatcher
  end # - Matchers
end # - ShouldaExt
