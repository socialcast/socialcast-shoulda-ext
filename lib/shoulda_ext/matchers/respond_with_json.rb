module ShouldaExt # :nodoc:
  module Matchers # :nodoc:
    
    def respond_with_json(json_or_description = nil, &block)
      RespondWithJsonMatcher.new(json_or_description, self, &block)
    end

    class RespondWithJsonMatcher
      
      def initialize(json_or_description, context, &block)
        @context = context
        @block = block
        if @block
          @description = json_or_description
        else
          @expected_json = json_or_description
        end
      end
      
      def description
        @description ||= "respond with JSON"
      end
      
      def failure_message
        "Expected to respond with json, but: #{errors.join("\n")}"
      end
      
      def errors
        @errors = []
        @errors << 'Failed to parse the response as JSON' if @failed_to_parse
        @errors << 'Failed to match json to expected value' unless @json_matched
        @errors
      end
      
      def matches?(subject)
        @body = subject.response.body
        begin
          @response_json = JSON.parse(body)
        rescue ParseError
          @failed_to_parse = true
        end
        
        if @expected_json
          @json_matched = (@expected_json == @response_json)
        else
          @block_result = @context.instance_eval(&@block)
          @json_matched = @block_result.nil? || (@block_result == @response_json)
        end
        
        errors.any?
      end
    end
    
  end
end
    