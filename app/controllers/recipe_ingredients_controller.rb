class RecipeIngredientsController < ApplicationController
  def new 
    @recipe_ingredient = RecipeIngredient.new
    @ingredients = Ingredient.all.order(:name)
    @recipes = Recipe.all.order(:name)
  end 

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient = @recipe.recipe_ingredients.create(recipe_ingredient_params)
    redirect_to recipe_path(@recipe)
  end 

  private
    def recipe_ingredient_params
      params.require(:recipe_ingredient).permit(
        :ingredient_id, 
        :quantity,
        :unit
      )
    end 
end 
