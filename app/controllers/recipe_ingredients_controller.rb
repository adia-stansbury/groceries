class RecipeIngredientsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_ingredient = @recipe.recipe_ingredients.create(recipe_ingredient_params)
    redirect_to recipe_path(@recipe)
  end 
  
  def edit
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @units = Unit.all.order(:name)
  end 

  def update
    @recipe_ingredient = RecipeIngredient.find(params[:id])

    if @recipe_ingredient.update(recipe_ingredient_params)
      redirect_to '/recipes'
    else
      render 'edit'
    end 
  end 

  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe_ingredient.destroy

    redirect_to recipes_path
  end 
  
  private
    def recipe_ingredient_params
      params.require(:recipe_ingredient).permit(
        :amount_in_grams,
        :ingredient_id, 
        :quantity,
        :unit_id
      )
    end 
end 
