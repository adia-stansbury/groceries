require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  setup do
    @unit = units(:unit)
  end

  test "strips user input" do
    @unit.update(name: ' name ')

    assert_equal('name', @unit.name)
  end
end
