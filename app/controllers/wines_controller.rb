class WinesController < ApplicationController
  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)

    if @wine.save
      redirect_to @wine
    else
      render 'new'
    end
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def index
    @wines = Wine.all
  end

  def update
    @wine = Wine.find(params[:id])

    if @wine.update(wine_params)
      redirect_to @wine
    else
      render 'edit'
    end
  end

  def edit
    @wine = Wine.find(params[:id])
  end

  def destroy
    @wine = Wine.find(params[:id])
    @wine.destroy

    redirect_to wines_path
  end

  private
    def wine_params
      params.require(:wine).permit(:winery, :variety, :color, :year, :appellation, :vineyard, :winemaker,
                                   :alcohol_content, :color, :sparkling, :bottle_size, :country, :maturity, :drink_by)
    end
end
