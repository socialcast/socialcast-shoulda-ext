
require 'shoulda_ext/matchers/record_count_change'
require 'shoulda_ext/matchers/trigger_callback'
require 'shoulda_ext/matchers/respond_with_json'

module ShouldaExt # :nodoc:
  module Matchers # :nodoc:
  end
end

module Test # :nodoc: all
  module Unit
    class TestCase
      extend ShouldaExt::Matchers
    end
  end
end

require 'active_record' unless defined? ActiveRecord
ActiveRecord::Base.send :include, ShouldaExt::Matchers::TriggerCallbackMatcher::ActiveRecordHooks
