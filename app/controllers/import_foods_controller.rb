class ImportFoodsController < ApplicationController
  def create
    food_list_service = FoodListService.new(params[:search_term])
    search_results = food_list_service.search_results
    if search_results
      begin
        Ingredient.create(food_list_service.ingredient_attributes)
      rescue ActiveRecord::RecordNotUnique
      end
    else
      flash[:notice] = 'No matching foods found'
    end
    redirect_to recipe_path(params[:recipe_id])
  end
end
