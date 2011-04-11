
module ActiveSupport # :nodoc: all
  class TestCase
    extend ShouldaExt::Matchers
    include ShouldaExt::Assertions
  end
end
