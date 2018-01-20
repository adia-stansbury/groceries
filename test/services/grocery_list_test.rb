require 'test_helper'

class GroceryListTest < ActiveSupport::TestCase
  test 'create returns formatted list' do
    items = [
      {
        'total_quantity' => 2,
        'is_for_first_day' => true,
        'unit' => 'fruit',
        'name' => 'apple',
        'recipe_names' => 'Buttery Apple Banana; Yogurt, Blackberry Chocolate',
      },
      {
        'total_quantity' => 3,
        'is_for_first_day' => false,
        'unit' => 'fruit',
        'name' => 'banana',
        'recipe_names' => 'Buttery Apple Banana',
      }
    ]

    expected = "<en-todo/><strong>2 fruit apple</strong> <i>(Buttery Apple Banana; Yogurt, Blackberry Chocolate)</i><br/><en-todo/><regular>3 fruit banana</regular> <i>(Buttery Apple Banana)</i><br/>"

    RecipeIngredient.connection.stub(:select_all, items) do
      assert_equal(expected, GroceryList.new(nil).create)
    end
  end
end
