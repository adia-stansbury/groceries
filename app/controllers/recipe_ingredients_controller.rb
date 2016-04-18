class RecipeIngredientsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient = @recipe.recipe_ingredients.create(recipe_ingredient_params)
    redirect_to recipe_path(@recipe)
  end 
  
  def edit
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end 

  def update
    @recipe_ingredient = RecipeIngredient.find(params[:id])

    if @recipe_ingredient.update(recipe_ingredient_params)
      redirect_to '/recipes'
    else
      render 'edit'
    end 
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
