require 'rubygems'
require 'bundler'
ENV['RAILS_ENV'] = 'test'
begin
  Bundler.setup(:default, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

# Load Rails 3 instance
rails_root = File.dirname(__FILE__) + '/rails3_root'
ENV['BUNDLE_GEMFILE'] = rails_root + '/Gemfile'
require "#{rails_root}/config/environment.rb"
require 'rails/test_help'

require 'shoulda'
require 'mocha'
require 'json'

# Load shoulda extensions
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'shoulda_ext'

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


