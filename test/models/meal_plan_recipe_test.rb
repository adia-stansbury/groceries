require 'test_helper'

class MealPlanRecipeTest < ActiveSupport::TestCase
  test 'new_records turns info hash into valid records to create' do
    info = [{ recipe_name: 'Roasted Kale', date: '06/30/2017' }]
    dictionary_name_id = { 'Roasted Kale' => 1 }

    results = MealPlanRecipe.new_records(info, dictionary_name_id)

    expected = [{ recipe_id: 1, date: '06/30/2017' }]

    assert_equal expected, results
  end
end
