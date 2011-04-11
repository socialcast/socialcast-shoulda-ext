
module ShouldaExt # :nodoc:
  module Matchers # :nodoc:
    
    # Test if a record of klass is created during the current setup/subject block
    # Equivilent to change_record_count.for(klass).by(1)
    def create_record(klass)
      RecordCountChangeMatcher.new.for(klass).by(1)
    end
    
    # Test if a record of klass is destroyed during the current setup/subject block
    # Equivilent to change_record_count.for(klass).by(-1)
    def destroy_record(klass)
      RecordCountChangeMatcher.new.for(klass).by(-1)
    end

    # Test if 'count' records of 'klass' are created during the current setup/subject block
    # Equivilent to change_record_count.for(klass).by(count)
    def create_records(klass, count)
      RecordCountChangeMatcher.new.for(klass).by(count)
    end

    # Test if 'count' records of 'klass' are destroyed during the current setup/subject block  
    # Equivilent to change_record_count.for(klass).by(-count)
    def destroy_records(klass, count)
      RecordCountChangeMatcher.new.for(klass).by(-count)
    end
  
    # Tests the difference in record count before and after the current setup/subject block
    # Can be used with the follow methods:
    #   - for(klass)
    #     Provides the class which the test is being performed on.  Can be a constant or a symbol
    #
    #   - by(count)
    #     Provides an expected difference for the number of records for the specified class.  If 
    #     this count is not specified, the matcher will test for any difference.
    #
    # Examples:
    # 
    #     context "creating a blog article" do
    # 
    #       context "with good parameters" do
    #         setup do
    #           post :create, :blog => {:title => 'my blog post', :body => 'Ipsum lorem...'}
    #         end
    # 
    #         # All of the below are synonomous
    #         should create_record Blog
    #         should create_record :blog
    #         should change_record_count.for(Blog).by(1)
    #       end
    # 
    #       context "without a body" do
    #         setup do
    #           post :create, :blog => {:title => 'my blog post' }
    #         end
    # 
    #         # All of the below are synonomous
    #         should_not create_record Blog
    #         should_not change_record_count.for(Blog)
    #       end
    # 
    #     end
    def change_record_count
      RecordCountChangeMatcher.new
    end
    
    class RecordCountChangeMatcher # :nodoc:

      def before
        @previous_count = @klass.count
      end

      def for(klass)
        klass = klass.to_s.classify.constantize if klass.is_a? Symbol
        @klass = klass
        self
      end
    
      def by(expected_change)
        @expected_change = expected_change
        self
      end

      def matches?(*)
        @new_count = @klass.count
        found_expected?
      end

      def description
        "expect #{@klass.name}.count to change#{" by #{@expected_change} records" if @expected_change }"
      end
    
      def failure_message
        "Expected #{errors.join("\n")}"
      end

      def negative_failure_message
        "Did not expect #{errors.join("\n")}"
      end
      
      def errors
        @errors = []
        @errors << "#{expected_count} #{@klass.name} records, but found #{@new_count}" if !found_expected? && @expected_change
        @errors << "#{@klass.name}.count to change" if !found_expected? && !@expected_change
        @errors
      end

      def expected_count
        @previous_count + @expected_change
      end

      def found_expected?
        if @expected_change
          expected_count == @new_count
        else
          @new_count != @previous_count
        end
      end

    end
  end
end
