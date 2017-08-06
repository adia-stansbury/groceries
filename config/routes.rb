Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'meal_plans#new'
  devise_for :users
  resources :grocery_lists
  resources :recipes do
    resources :recipe_ingredients, only: :create
  end
  resources :recipe_ingredients, only: [:edit, :update, :destroy]
  resources :ingredients
  resources :locations
  resources :consumers
  resources :meal_plan_recipes, only: [:edit, :update, :destroy]
  resources :meal_plans, only: [:index, :show, :new, :create] do
    resources :meal_plan_recipes, only: :create
    resources :meal_plan_recipe_days, only: :show
  end
  resources :generate_template_meal_plans, only: :new
  resources :google_calendar_generated_meal_plans, only: :new
end
