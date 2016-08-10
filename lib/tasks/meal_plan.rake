namespace :meal_plan do
  desc "create template meal plans for Mick and Adia" 
  task generate_template: :environment do
    adia_meal_plan = MealPlan.create(consumer_id: 1)
    mick_meal_plan = MealPlan.create(consumer_id: 4)
    MealPlanRecipe.create(
      [{ 
        # yogurts
        meal_plan_id: adia_meal_plan.id,
        recipe_id: 7, 
        number_of_recipes: 1
      },
      { 
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 13, 
        number_of_recipes: 1
      },
      {
        # 3 apples
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        # 3 carbonated waters
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 21, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 21, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 21, 
        number_of_recipes: 1
      }]
    )
  end 
end 
