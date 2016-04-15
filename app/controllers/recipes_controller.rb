class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(:name) 
  end 

  def show
    @recipe = Recipe.find(params[:id])
  end 

  def new
    @recipe = Recipe.new
  end 

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to '/recipe_ingredients/new'
    else
      render 'new'
    end 
  end 

  private
    def recipe_params
      params.require(:recipe).permit(:name)
    end 
end
