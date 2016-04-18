class IngredientsController < ApplicationController
  def index 
    @ingredients = Ingredient.all.order(:name)
  end 

  def show
    @ingredient = Ingredient.find(params[:id])
    ndb_usda_api_key = ENV['NDB_USDA_API_KEY']
    @response = HTTParty.get(
      "http://api.nal.usda.gov/ndb/list?format=json&lt=n&max=1500&api_key=#{ndb_usda_api_key}"
    )['list']['item']
    if @ingredient.ndbno.present?
      ndb_usda_api_key = ENV['NDB_USDA_API_KEY']
      ndbno = @ingredient.ndbno
      response = HTTParty.get("http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{ndb_usda_api_key}")
      nutrient_results = response['report']['food']['nutrients']
      @parsed_nutrient_data = {}
      nutrient_results.each do |nutrient|
        @parsed_nutrient_data[nutrient['name']] = "#{nutrient['value']} #{nutrient['unit']}"
      end 
      @parsed_nutrient_data
    end 
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

  def update
    @ingredient = Ingredient.find(params[:id])

    if @ingredient.update(recipe_params)
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
