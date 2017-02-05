require 'rails_helper'

RSpec.describe EvernoteApiService do
  describe '.make_note_body' do
    it 'returns list of grocery items with its recipe name' do
      shopping_list = [
        { 'total_quantity' => 1, 'unit' => 'fruit', 'name' => 'apple', 'recipe_name' => 'Buttery Apple Banana' },
        { 'total_quantity' => 1, 'unit' => 'fruit', 'name' => 'apple', 'recipe_name' => 'Black Bean Soup' },
        { 'total_quantity' => 1, 'unit' => 'can', 'name' => 'peanut butter', 'recipe_name' =>'Buttery Apple Banana' },
        { 'total_quantity' => 1, 'unit' => 'jar', 'name' => 'black beans', 'recipe_name' => 'Black Bean Soup' },
      ]

      expected = "<en-todo/>1 fruit apple (Buttery Apple Banana)<br/><en-todo/>1 fruit apple (Black Bean Soup)<br/><en-todo/>1 can peanut butter (Buttery Apple Banana)<br/><en-todo/>1 jar black beans (Black Bean Soup)<br/>"
      result = EvernoteApiService.make_note_body(shopping_list)

      expect(result).to eq(expected)
    end
  end
end
