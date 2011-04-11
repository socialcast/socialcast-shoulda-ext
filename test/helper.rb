ENV['RAILS_ENV'] = 'test'

# Load Rails 3 instance
rails_root = File.join(File.dirname(__FILE__), 'rails3_root')
ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
require "#{rails_root}/config/environment.rb"
require 'rails/test_help'

# Load shoulda extensions
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'shoulda_ext'

# Activate ActiveRecord hooks for trigger_callbacks matcher
ShouldaExt::Matchers::TriggerCallbackMatcher.attach_active_record_callback_hooks!

# Run the migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")

# Setup the fixtures path
ActiveSupport::TestCase.fixture_path =
  File.join(File.dirname(__FILE__), "rails3_root/test/fixtures")

class ActiveSupport::TestCase #:nodoc:
  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures  = false
end


