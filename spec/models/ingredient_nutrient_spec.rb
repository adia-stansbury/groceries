require 'rails_helper'
require Rails.root.join "spec/models/concerns/nutrient_targets_spec.rb"

RSpec.describe IngredientNutrient, type: :model do
  it_behaves_like 'nutrient_targets'
end
