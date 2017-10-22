require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  setup do
    @ingredient = ingredients(:ingredient)
  end

  test "strips user input" do
    @ingredient.update(ndbno: ' 1234 ')

    assert_equal('1234', @ingredient.ndbno)
  end
end
