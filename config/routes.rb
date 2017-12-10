Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'meal_plans#new'
  resources :grocery_lists
  resources :recipes do
    resources :recipe_ingredients, only: :create
  end
  resources :recipe_ingredients, only: [:edit, :update, :destroy]
  resources :ingredients
  # TODO: can probably delete this resource
  resources :locations
  resources :meal_plan_recipes, only: :destroy
  resources :meal_plans, only: [:index, :show, :new, :create] do
    resources :meal_plan_recipes, only: :create
  end
end
