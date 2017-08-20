FactoryGirl.define do
  factory :consumer do
    sequence(:name) {|n| "Name#{n}"}
    weight_in_lbs 124
  end

  factory :food_mealsquare, class: Food do
    name 'Mealsquare'
  end

  factory :food_soylent, class: Food do
    name 'Soylent'
  end

  factory :ingredient do
    sequence(:name) {|n| "ingredient#{n}"}
    location
  end

  factory :ingredient_nutrient do
    value 1
    unit 'mg'
    nutrient
    ingredient
  end

  factory :location do
    sequence(:name) {|n| "Produce#{n}"}
    ordering 100
  end

  factory :meal_plan do
    consumer
    created_at Time.now
  end

  factory :meal_plan_recipe do
    meal_plan
    recipe
    sequence(:date) {|n| Date.today + n}
  end

  factory :nutrient do
    sequence(:name) {|n| "Zinc#{n}"}
  end

  factory :nutrient_group do
    sequence(:name) {|n| "Nutrient Group #{n}"}
  end

  factory :recipe do
    sequence(:name) {|n| "recipe#{n}" }
    number_of_servings 1
  end

  factory :recipe_ingredient do
    recipe
    ingredient
    quantity '2'
    unit
    amount_in_grams 100
  end

  factory :unit do
    sequence(:name) {|n| "Unit#{n}"}
  end
end
