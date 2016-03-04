class IngredientsController < ApplicationController
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

  private
    def ingredient_params
      params.require(:ingredient).permit(
        :name, 
        :location_id
      )
    end 
end 

