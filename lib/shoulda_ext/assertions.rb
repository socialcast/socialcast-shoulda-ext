
module ShouldaExt
  module Assertions
    
    def assert_blank(object, message = nil)
      assert(object.blank?, message || "Expected object to be blank")
    end

    def assert_not_blank(object, message = nil)
      assert(!object.blank?, message || "Expected object to not be blank")
    end

  end
end



