require 'rails_helper'
require Rails.root.join "spec/controllers/concerns/recipe_nutrient_intake_spec.rb"

RSpec.describe Recipe, type: :model do
  it_behaves_like 'recipe_nutrient_intake'
end
