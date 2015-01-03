class BottlesController < ApplicationController
  def create
    @wine = Wine.find(params[:wine_id])
    @bottles = @wine.bottles.create(bottle_params)

    redirect_to wine_path(@wine)
  end

  private
    def bottle_params
      params.require(:bottle).permit(:purchased_from, :purchase_price, :purchase_date, :location, :consumed_date)
    end
end

