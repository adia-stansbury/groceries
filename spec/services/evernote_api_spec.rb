require 'rails_helper'

RSpec.describe EvernoteApi do
  describe '.make_note_body' do
    it 'returns list of grocery items with recipe names' do
      shopping_list = [{
        'total_quantity' => 2,
        'unit' => 'fruit',
        'name' => 'apple',
        'recipe_names' => 'Buttery Apple Banana, Black Bean Soup'
      }]

      expected = "<en-todo/>2 fruit apple <i>(Buttery Apple Banana, Black Bean Soup)</i><br/>"
      result = EvernoteApi.make_note_body(shopping_list)

      expect(result).to eq(expected)
    end
  end
end
