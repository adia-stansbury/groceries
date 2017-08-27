class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(:name)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.order(:name)
    @units = Unit.order(:name)
    @recipe_ingredients = @recipe.recipe_ingredients.includes(:ingredient, :unit).
      order('ingredients.name')
    @groups = NutrientGroup.includes(:nutrients).order(:name)
    @aggregate_nutrient_intake = @recipe.nutrient_intake
    @nutrients_upper_limit = Nutrient.upper_limit_hash
    @consumers = Consumer.where(name: ['Mick', 'Adia'])
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
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
      params.require(:recipe).permit(:name, :note, :number_of_servings)
    end
end
