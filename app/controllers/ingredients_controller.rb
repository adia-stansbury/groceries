class IngredientsController < ApplicationController
  def index 
    @ingredients = Ingredient.all.order('LOWER(name)')
  end 

  def show
    @ingredient = Ingredient.find(params[:id])
    @groups = NutrientGroup.all.order(:name)
  end 

  def new
    @ingredient = Ingredient.new
    @locations = Location.all.order(:name)
  end 

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @groups = NutrientGroup.all.order(:name)

    if @ingredient.save
      render 'show'
    else
      render 'new'
    end 
  end 

  def edit
    @ingredient = Ingredient.find(params[:id])
    @locations = Location.all.order(:name)
  end 

  def update
    @ingredient = Ingredient.find(params[:id])

    if @ingredient.update(ingredient_params)
      redirect_to @ingredient
    else
      render 'edit'
    end 
  end 

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

    redirect_to ingredients_path
  end 
  
  private
    def ingredient_params
      params.require(:ingredient).permit(
        :food_source_id,
        :location_id,
        :name, 
        :ndbno
      )
    end 
end 
