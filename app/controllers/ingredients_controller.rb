class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.order('LOWER(name)')
  end

  def show
    @ingredient = Ingredient.includes(:unit).find(params[:id])
    @ndbno = @ingredient.try(:ndbno)
    @unit = @ingredient.unit.try(:name)
    @groups = NutrientGroup.includes(:nutrients).order(:name)
  end

  def new
    @ingredient = Ingredient.new
    @locations = Location.order(:name)
    @units = Unit.order(:name)
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to @ingredient
    else
      render 'new'
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @locations = Location.order(:ordering)
    @units = Unit.order(:name)
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
        :measuring_amount,
        :name,
        :ndbno,
        :note,
        :num_of_grams_in_measuring_amount,
        :unit_id
      )
    end
end
