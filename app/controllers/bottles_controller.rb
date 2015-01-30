class BottlesController < ApplicationController
  def create
    @wine = Wine.find(params[:wine_id])
    @bottles = @wine.bottles.create(bottle_params)

    redirect_to wine_path(@wine)
  end

  def destroy
    @wine = Wine.find(params[:wine_id])
    @bottle = @wine.bottles.find(params[:id])
    @bottle.destroy
    redirect_to wine_path(@wine)
  end

  def new
    @wine = Wine.find(params[:wine_id])
    @bottle = @wine.build
    @path = [@wine, @bottle]
  end

  def edit
    @bottle = Bottle.find(params[:id])
    @path = @bottle
  end

  def update
    @bottle = Bottle.find(params[:id])
    @bottle.update_attributes(bottle_params)
    redirect_to wine_path(@bottle.wine)
  end

  def drink
    @bottle = Bottle.find(params[:id])
    @bottle.location = ""
    @bottle.consumed_date = Date.today
    @bottle.save
    redirect_to wine_path(@bottle.wine)
  end

  private
    def bottle_params
      params.require(:bottle).permit(:purchased_from, :purchase_price, :purchase_date, :location, :consumed_date)
    end
end

