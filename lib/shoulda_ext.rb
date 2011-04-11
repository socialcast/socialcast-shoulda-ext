require 'shoulda_ext/version'

require 'shoulda'
require 'shoulda_ext/shoulda_patches/context_with_matcher_before_hooks'
require 'shoulda_ext/assertions'
require 'shoulda_ext/matchers'

if defined?(RSpec)
  require 'shoulda_ext/integrations/rspec2'
elsif defined?(Spec)
  require 'shoulda_ext/integrations/rspec'
else
  require 'shoulda_ext/integrations/test_unit'
end

