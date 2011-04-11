module ShouldaExt # :nodoc:
  module Matchers # :nodoc:
    
    def respond_with_json(description = nil, &block)
      RespondWithJsonMatcher.new(self, description, &block)
    end

    class RespondWithJsonMatcher
      attr_accessor :expected_value
      
      def initialize(context, description = nil, &block)
        @context = context
        @block = block || lambda{|*| true }
        @description = description
        @exactly = false
      end
      
      def exactly(expected_json = nil, &block)
        @exactly = true
        @expected_value = expected_json
        @block = block
        self
      end
      
      def description
        @description ||= "respond with JSON"
      end
      
      def failure_message
        "Expected to respond with json, but: #{errors.join("\n")}"
      end
      
      def negative_failure_message
        "Expected not to respond with json, but: #{errors.join("\n")}"
      end
      
      def errors
        @errors = []
        @errors << 'Failed to parse the response as JSON' unless @parsable
        @errors << "Failed to #{'exactly ' if @exactly}match json: expected #{@exactly ? @expected_value.inspect : true}, but found #{@exactly ? @response_json.inspect : @block_result} " unless @json_matched
        @errors
      end
      
      def json_matched?
        @expected_value ||= run_block
        @json_matched ||= @exactly ? @response_json == @expected_value : !!@block_result
      end
      
      def run_block
        @block_result = @context.instance_exec(@response_json, &@block)
      end
      
      def parsable?
        @parsable = true
        @response_json = JSON.parse(@subject.response.body)
      rescue
        @parsable = false
      end
      
      def matches?(subject)
        @subject = subject
        parsable? and json_matched?
      end
    end
    
  end
end
    