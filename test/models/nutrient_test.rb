require 'test_helper'

class NutrientTest < ActiveSupport::TestCase
  setup do
    @nutrient = nutrients(:nutrient)
  end

  test "strips user input" do
    @nutrient.update(name: ' name ')

    assert_equal('name', @nutrient.name)
  end
end
