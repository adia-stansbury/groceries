desc 'populate FoodNutrient table'
task add_food_nutrients_data: :environment do

  def food_id(name)
    Food.find_or_create_by(name: name).id
  end 

  def new_data(food_id, nutrient_id, nutrient_amount)
    { food_id: food_id, nutrient_id: nutrient_id, nutrient_amount: nutrient_amount }
  end 

  mealsquare_id = food_id('Mealsquare')
  soylent_id = food_id('Soylent')

  nutrients = Nutrient.where.not(nutrient_group_id: nil).pluck(:name, :id).to_h

  FoodNutrient.create([
    new_data(mealsquare_id, nutrients['Energy'], 400),
    new_data(mealsquare_id, nutrients['Sodium, Na'], 529),
    new_data(mealsquare_id, nutrients['Fiber, total dietary'], 5.5),
    new_data(mealsquare_id, nutrients['Sugars, total'], 17),
    new_data(mealsquare_id, nutrients['Total lipid (fat)'], 20),
    new_data(mealsquare_id, nutrients['Fatty acids, total monounsaturated'], 10),
    new_data(mealsquare_id, nutrients['Fatty acids, total polyunsaturated'], 4),
    new_data(mealsquare_id, nutrients['Fatty acids, total saturated'], 4),
    new_data(mealsquare_id, nutrients['Fatty acids, total trans'], 0),
    new_data(mealsquare_id, nutrients['Cholesterol'], 60),
    new_data(mealsquare_id, nutrients['Carbohydrate, by difference'], 36),
    new_data(mealsquare_id, nutrients['Protein'], 20),
    new_data(mealsquare_id, nutrients['Calcium, Ca'], 200),  
    new_data(mealsquare_id, nutrients['Copper, Cu'], 0.5),
    new_data(mealsquare_id, nutrients['Folic acid'], 80),
    new_data(mealsquare_id, nutrients['Iron, Fe'], 3.6),
    new_data(mealsquare_id, nutrients['Magnesium, Mg'], 140),
    new_data(mealsquare_id, nutrients['Niacin'], 4),
    new_data(mealsquare_id, nutrients['Potassium, K'], 840),
    new_data(mealsquare_id, nutrients['Riboflavin'], 0.34),
    new_data(mealsquare_id, nutrients['Selenium, Se'], 14),
    new_data(mealsquare_id, nutrients['Thiamin'], 0.3),
    new_data(mealsquare_id, nutrients['Vitamin A, IU'], 1000),
    new_data(mealsquare_id, nutrients['Vitamin B-12'], 1.8),
    new_data(mealsquare_id, nutrients['Vitamin B-6'], 0.4),
    new_data(mealsquare_id, nutrients['Vitamin C, total ascorbic acid'], 30),
    new_data(mealsquare_id, nutrients['Vitamin D'], 200), 
    new_data(mealsquare_id, nutrients['Vitamin E (alpha-tocopherol)'], 4),
    new_data(mealsquare_id, nutrients['Vitamin K (phylloquinone)'], 24),
    new_data(mealsquare_id, nutrients['Zinc, Zn'], 3.75),
    new_data(soylent_id, nutrients['Energy'], 500),
    new_data(soylent_id, nutrients['Sodium, Na'], 380),
    new_data(soylent_id, nutrients['Fiber, total dietary'], 7),
    new_data(soylent_id, nutrients['Sugars, total'], 19),
    new_data(soylent_id, nutrients['Total lipid (fat)'], 25),
    new_data(soylent_id, nutrients['Fatty acids, total monounsaturated'], 17),
    new_data(soylent_id, nutrients['Fatty acids, total polyunsaturated'], 4.5),
    new_data(soylent_id, nutrients['Fatty acids, total saturated'], 2.5),
    new_data(soylent_id, nutrients['Fatty acids, total trans'], 0),
    new_data(soylent_id, nutrients['Cholesterol'], 0),
    new_data(soylent_id, nutrients['Carbohydrate, by difference'], 47),
    new_data(soylent_id, nutrients['Protein'], 25),
    new_data(soylent_id, nutrients['Calcium, Ca'], 250),  
    new_data(soylent_id, nutrients['Choline, total'], 107),   
    new_data(soylent_id, nutrients['Copper, Cu'], 0.5), 
    new_data(soylent_id, nutrients['Folic acid'], 100), 
    new_data(soylent_id, nutrients['Iron, Fe'], 4.5),
    new_data(soylent_id, nutrients['Magnesium, Mg'], 100),
    new_data(soylent_id, nutrients['Manganese, Mn'], 0.5),
    new_data(soylent_id, nutrients['Niacin'], 5),
    new_data(soylent_id, nutrients['Potassium, K'], 875),
    new_data(soylent_id, nutrients['Riboflavin'], 0.43),
    new_data(soylent_id, nutrients['Selenium, Se'], 17.5),
    new_data(soylent_id, nutrients['Thiamin'], 0.375),
    new_data(soylent_id, nutrients['Vitamin A, IU'], 1250), 
    new_data(soylent_id, nutrients['Vitamin B-12'], 1.5),
    new_data(soylent_id, nutrients['Vitamin B-6'], 0.5),
    new_data(soylent_id, nutrients['Vitamin C, total ascorbic acid'], 15),
    new_data(soylent_id, nutrients['Vitamin D'], 100), 
    new_data(soylent_id, nutrients['Vitamin E (alpha-tocopherol)'], 5),
    new_data(soylent_id, nutrients['Vitamin K (phylloquinone)'], 20),
    new_data(soylent_id, nutrients['Zinc, Zn'], 3.75)
  ])
end 
