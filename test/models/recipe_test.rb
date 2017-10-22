require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  setup do
    @recipe = recipes(:recipe)
  end

  test "strips user input" do
    @recipe.update(name: ' name ')

    assert_equal('Name', @recipe.name)
  end
end
