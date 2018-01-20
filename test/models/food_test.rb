require 'test_helper'

class FoodTest < ActiveSupport::TestCase
  setup do
    @food = foods(:soylent)
  end

  test 'strips user input' do
    @food.update(name: ' name ')

    assert_equal('name', @food.name)
  end
end
