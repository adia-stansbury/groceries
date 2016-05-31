class MealPlanRecipe < ActiveRecord::Base
  belongs_to :meal_plan
  belongs_to :recipe

  #before_save :create_meal_plan
  #before_save :update_meal_plan_fk

  private
  def create_meal_plan
    MealPlan.create(consumer_id: params[:consumer_id])
  end 

  def update_meal_plan_fk
    self.meal_plan_id = create_meal_plan.id
  end 
end 
