
module Test # :nodoc: all
  module Unit
    class TestCase
      extend ShouldaExt::Matchers
      include ShouldaExt::Assertions
    end
  end
end
