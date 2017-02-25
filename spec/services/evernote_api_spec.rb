require 'rails_helper'

RSpec.describe EvernoteApi do
  describe '.make_note_body' do
    it 'returns formatted grocery list' do
      shopping_list = [
        {
          'total_quantity' => 2,
          'unit' => 'fruit',
          'name' => 'apple',
          'recipe_names' => 'Buttery Apple Banana; Yogurt, Blackberry Chocolate'
        },
        {
          'total_quantity' => 3,
          'unit' => 'fruit',
          'name' => 'banana',
          'recipe_names' => 'Buttery Apple Banana'
        }
      ]

      first_day_recipes = ['Black Bean Soup', 'Yogurt, Blackberry Chocolate']

      expected = "<en-todo/><strong>2 fruit apple</strong> <i>(Buttery Apple Banana; Yogurt, Blackberry Chocolate)</i><br/><en-todo/>3 fruit banana <i>(Buttery Apple Banana)</i><br/>"
      result = EvernoteApi.make_note_body(shopping_list, first_day_recipes)

      expect(result).to eq(expected)
    end
  end
end
