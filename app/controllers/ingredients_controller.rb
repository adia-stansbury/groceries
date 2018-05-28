class IngredientsController < ApplicationController
  def index
    ingredients = ActiveRecord::Base.connection.exec_query(
      "SELECT id, name
      FROM ingredients
      WHERE name ILIKE '%" + params[:search] + "%'
      LIMIT(20)"
    ).to_hash
    render json: { items: ingredients }
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

    if @ingredient.update(ingredient_params)
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
      :unit_id,
    )
  end
end
