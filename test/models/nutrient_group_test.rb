require 'test_helper'

class NutrientGroupTest < ActiveSupport::TestCase
  setup do
    @nutrient_group = nutrient_groups(:nutrient_group)
  end

  test "strips user input" do
    @nutrient_group.update(name: ' name ')

    assert_equal('name', @nutrient_group.name)
  end
end
