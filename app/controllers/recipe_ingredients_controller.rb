class RecipeIngredientsController < ApplicationController
  def new 
    @recipe_ingredient = RecipeIngredient.new
    @ingredients = Ingredient.all.order(:name)
    @recipes = Recipe.all.order(:name)
  end 

  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)

    if @recipe_ingredient.save
      redirect_to '/recipe_ingredients/new'
    else
      render 'new'
    end 
  end 

  private
    def recipe_ingredient_params
      params.require(:recipe_ingredient).permit(
        :recipe_id, 
        :ingredient_id, 
        :quantity,
        :unit
      )
    end 
end 
