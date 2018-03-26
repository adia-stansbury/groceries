require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  setup do
    @ingredient = ingredients(:ingredient)
  end

  test "strips user input" do
    @ingredient.update(ndbno: ' 1234 ')

    assert_equal('1234', @ingredient.ndbno)
  end

  test "formats name having UPC" do
    @ingredient.update(name: 'ABC, PEANUT BUTTER, UPC: 837991219186')

    assert_equal('Abc, peanut butter', @ingredient.name)
  end

  test "formats name having GTIN" do
    @ingredient.update(name: 'ABC, PEANUT BUTTER, GTIN: 837991219186')

    assert_equal('Abc, peanut butter', @ingredient.name)
  end

  test "#missing_nutritional_info? returns true if it has an ndbno but no IngredientNutrient records exist" do
    assert ingredients(:ingredient_with_ndbno).missing_nutritional_info?
  end
end
