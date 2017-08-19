class ConsumersController < ApplicationController
  def index
    @consumers = Consumer.order('UPPER(name)')
  end

  def show
    @consumer = Consumer.find(params[:id])
  end
end
