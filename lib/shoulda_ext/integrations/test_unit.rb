
require 'shoulda_ext/assertions'
require 'shoulda_ext/matchers'
require 'test/unit'

module Test # :nodoc: all
  module Unit
    class TestCase
      extend ShouldaExt::Matchers
      include ShouldaExt::Assertions
    end
  end
end
