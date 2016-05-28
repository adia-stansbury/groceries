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
    recipe_ingredient_ids = @recipe.recipe_ingredients.pluck(:ingredient_id)
    recipe_ingredient_nutrients = IngredientNutrient.where(ingredient_id: recipe_ingredient_ids)
    aggregate_nutrient_hash = {}
    recipe_ingredient_nutrients.each do |record|
      grams_of_recipe_ingredient = RecipeIngredient.where(
        ingredient_id: record.ingredient_id, recipe_id: @recipe.id
      ).first.try(:amount_in_grams)
      if grams_of_recipe_ingredient == nil
        grams_of_recipe_ingredient = 0
      end
      nutrient_intake_per_ing = (record.value/100) * grams_of_recipe_ingredient
      if aggregate_nutrient_hash.has_key?([record.nutrient_id, record.unit])
        aggregate_nutrient_hash[[record.nutrient_id, record.unit]] += nutrient_intake_per_ing
      else
        aggregate_nutrient_hash[[record.nutrient_id, record.unit]] = nutrient_intake_per_ing     
      end 
      @aggregate_nutrient_hash = aggregate_nutrient_hash
    end 
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
