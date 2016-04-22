class IngredientsController < ApplicationController
  def index 
    @ingredients = Ingredient.all.order(:name)
  end 

  def show
    @ingredient = Ingredient.find(params[:id])
    nutrient_names = [
      'Calcium, Ca',
      'Cholesterol',
      'Energy',
      'Fiber, total dietary',
      'Iron, Fe',
      'Lactose',
      'Magnesium, Mg',
      'Manganese, Mn',
      'Niacin',
      'Potassium, K',
      'Protein',
      'Selenium, Se',
      'Sodium, Na',
      'Sugars, total',
      'Thiamin',
      'Total lipid (fat)',
      'Tryptophan',
      'Tyrosine',
      'Valine',
      'Vitamin A, IU',
      'Vitamin B-12',
      'Vitamin B-6',
      'Vitamin C',
      'Vitamin D',
      'Vitamin E, added',
      'Vitamin K (phylloquinone)',
      'Water',
      'Zinc, Zn'
    ]
    nutrient_ids = Nutrient.where(name: nutrient_names).pluck(:id)
    @nutrition = IngredientNutrient.includes(:nutrient).where(
      ingredient_id: @ingredient.id, 
      nutrient_id: nutrient_ids
    ).order('nutrients.name')
  end 

  def new
    @ingredient = Ingredient.new
    @locations = Location.all.order(:name)
  end 

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to '/ingredients/new'
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
        :name, 
        :ndbno,
        :location_id
      )
    end 
end 
