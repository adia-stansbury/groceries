class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(:name) 
  end 

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.all.order(:name)
    @recipe_ingredients = @recipe.recipe_ingredients.includes(
      :ingredient).order('ingredients.name')
    @groups = NutrientGroup.all.order(:name)
  end 

  def new
    @recipe = Recipe.new
  end 

  def edit
    @recipe = Recipe.find(params[:id])
  end 

  def create
    @recipe = Recipe.new(recipe_params)
    @ingredients = Ingredient.all.order(:name)
    @recipe_ingredients = @recipe.recipe_ingredients.includes(
      :ingredient).order('ingredients.name')

    if @recipe.save
      render 'show'
    else
      render 'new'
    end 
  end 

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end 
  end 

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end 

  private
    def recipe_params
      params.require(:recipe).permit(:name)
    end 
end
