module ShouldaExt # :nodoc:
  module Matchers # :nodoc:
    
    # Check if the controller's response is json
    # 
    # Example uses:
    #  context ":index.json" do
    #   setup do
    #     get :index, :format => 'json'
    #   end
    #   # Just check to see that the response was json
    #   should respond_with_json  
    #
    #   # Evaluate the hash produced by the json yourself
    #   should respond_with_json { |json| json.first['blog']['title'] == 'blog post 1'}
    #   
    #   # Provide an exact match
    #   should respond_with_json.exactly(['blog' => {'id' => 1, 'title' => 'blog post 1'}])
    #
    #   # Provide an exact match with a block
    #   should response_with_json.exactly{ |json| JSON.parse(Blog.all.to_json)}
    # end
    #  
    # context ":index.html" do
    #   setup do
    #     get :index
    #   end
    #  
    #   # or the negation
    #   should_not respond_with_json
    # end 
    def respond_with_json(description = nil, &block)
      RespondWithJsonMatcher.new(self, description, &block)
    end

    class RespondWithJsonMatcher
      def initialize(context, description = nil, &block)
        @context = context
        @block = block || lambda{|*| true }
        @description = description
        @exactly = false
      end
      
      # Provide an exact result directly or using a block argument
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
    