class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.order('LOWER(name)')
  end

  def show
    @ingredient = Ingredient.includes(:unit).find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
    @locations = Location.order(:name)
    @units = Unit.order(:name)
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      if @ingredient.ndbno
        create_ingredient_nutrients
      end
      redirect_to @ingredient
    else
      redirect_to new_ingredient_path
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @locations = Location.order(:ordering)
    @units = Unit.order(:name)
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    old_ndbno = @ingredient.ndbno

    if @ingredient.update(ingredient_params)
      new_ndbno = @ingredient.ndbno
      if new_ndbno && (new_ndbno != old_ndbno)
        create_ingredient_nutrients
      end
      redirect_to @ingredient
    else
      redirect_to edit_ingredient_path(@ingredient)
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy!

    redirect_to ingredients_path
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(
      :location_id,
      :measuring_amount,
      :name,
      :ndbno,
      :note,
      :num_of_grams_in_measuring_amount,
      :unit_id
    )
  end

  def create_ingredient_nutrients
    dictionary = Nutrient.name_id_dictionary
    nutrition = Nutrition.for_ingredient(@ingredient)
    new_rows = FormatData.to_ingredient_nutrient_rows(nutrition, dictionary)
    @ingredient.ingredient_nutrients.create(new_rows)
  end
end
