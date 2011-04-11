
require File.join(File.dirname(__FILE__), 'helper')

class TestAssertions < Test::Unit::TestCase
  def test_assert_blank
    blankable_object = mock('blankable', {:blank? => true})
    assert_blank blankable_object
  end
  
  def test_assert_not_blank
    blankable_object = mock('blankable', {:blank? => false})
    assert_not_blank blankable_object
  end
end
