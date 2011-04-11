
# Adds the ability to define a 'before' method on a matcher and allow 
# it to be run before the subject/setup phase of the current context
# 
# Pull Request for getting this functionality into shoulda-context
# https://github.com/thoughtbot/shoulda-context/pull/2
module Shoulda
  class Context
    def should(name_or_matcher, options = {}, &blk)
      if name_or_matcher.respond_to?(:description) && name_or_matcher.respond_to?(:matches?)
        name = name_or_matcher.description
        blk = lambda { assert_accepts name_or_matcher, subject }
        options[:before] = lambda { name_or_matcher.before } if name_or_matcher.respond_to?(:before)
      else
        name = name_or_matcher
      end

      if blk
        self.shoulds << { :name => name, :before => options[:before], :block => blk }
      else
       self.should_eventuallys << { :name => name }
     end
    end

    def should_not(matcher)
      name = matcher.description
      blk = lambda { assert_rejects matcher, subject }
      before = matcher.respond_to?(:before) ? lambda { matcher.before } : nil
      self.shoulds << { :name => "not #{name}", :block => blk, :before => before }
    end
  end
end
