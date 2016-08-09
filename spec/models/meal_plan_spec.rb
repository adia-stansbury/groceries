require 'rails_helper'
require Rails.root.join "spec/controllers/concerns/meal_plan_nutrient_intake_spec.rb"

RSpec.describe MealPlan, type: :model do
  it_behaves_like 'meal_plan_nutrient_intake'
end
