require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  setup do
    @location = locations(:location)
  end

  test "strips user input" do
    @location.update(name: ' name ')

    assert_equal('name', @location.name)
  end
end
