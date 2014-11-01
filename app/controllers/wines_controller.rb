class WinesController < ApplicationController
  def new
  end

  def create
    @wine = Wine.new(wine_params)

    @wine.save
    redirect_to @wine
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def index
    @wines = Wine.all
  end

  private
    def wine_params
      params.require(:wine).permit(:winery, :variety, :color, :year, :appellation, :vineyard, :winemaker,
                                   :alcohol_content, :color, :sparkling, :bottle_size, :country, :maturity, :drink_by)
    end
end
