
module ActiveSupport
  class TestCase
    extend ShouldaExt::Matchers
    include ShouldaExt::Assertions
  end
end
