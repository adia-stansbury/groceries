require 'factory_girl'

FactoryGirl.define do
  factory :consumer do
    id 1
    name 'Adia'
    weight_in_lbs 124
  end 

  factory :consumer_nutrient do
    id 1
  end 

  factory :food do
    name 'Soylent'
  end 

  factory :food_source do
    id 2
    name 'plant'
  end 

  factory :ingredient do
    name 'kale' 
  end 

  factory :ingredient_nutrient

  factory :location do
    id 1
    name 'produce'
    ordering 100
  end 

  factory :meal_plan do
    consumer_id 1
    created_at Time.now
  end 

  factory :meal_plan_recipe

  factory :nutrient do
    name 'Zinc, Zn'
  end 

  factory :recipe do
    name 'Grilled Veggies'
    number_of_servings 1.0
  end 

  factory :recipe_ingredient do
    unit_id 1
    quantity '1.0'
  end 

  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :unit do
    id 1
    name 'fruit'
  end 
end
