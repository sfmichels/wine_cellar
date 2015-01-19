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
    @available_bottles = Bottle.where(wine_id: @wine.id).where(consumed_date: nil)
  end

  def index
    #@q = Bottle.ransack(params[:q])
    #Bottle = @q.result.includes(:wines)
    #@wines = Wine.all
    @search = Wine.ransack(params[:q])
    @wines = @search.result
    @search.build_condition
  end

  def search # or index
    @search = Wine.search(params[:q])
    @wines = @search.result
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
                                   :alcohol_content, :sparkling, :bottle_size, :country, :maturity, :drink_by,
                                    bottles_attributes: [:id, :purchased_from, :purchase_price, :location,
                                                        :purchase_date, :consumed_date, :_destroy])
    end
end
