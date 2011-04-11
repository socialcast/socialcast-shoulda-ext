
module ShouldaExt
  module Assertions
    # Asserts the result of object.blank?
    def assert_blank(object, message = nil)
      assert(object.blank?, message || "Expected object to be blank")
    end

    # Asserts the result of !object.blank?
    def assert_not_blank(object, message = nil)
      assert(!object.blank?, message || "Expected object to not be blank")
    end
  end
end



