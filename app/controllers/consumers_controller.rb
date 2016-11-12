class ConsumersController < ApplicationController
  def index 
    @consumers = Consumer.order('UPPER(name)')
  end 

  def show
    @consumer = Consumer.find(params[:id])
  end 

  def new
    @consumer = Consumer.new
  end 

  def create
    @consumer = Consumer.new(consumer_params)

    if @consumer.save
      render 'show'
    else
      render 'new'
    end 
  end 

  def edit
    @consumer = Consumer.find(params[:id])
    @recipes = Recipe.order(:name) 
  end 

  def update
    @consumer = Consumer.find(params[:id])

    if @consumer.update(consumer_params)
      render 'show'
    else
      render 'edit'
    end 
  end 

  def destroy
    @consumer = Consumer.find(params[:id])
    @consumer.destroy

    redirect_to consumers_path
  end 
  
  private
    def consumer_params
      params.require(:consumer).permit(:name, recipe_ids: [])
    end 
end 
