class WinesController < ApplicationController
  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(wine_params)

    if @wine.save!
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
    @q = Wine.search(params[:q])
    @wines = @q.result.page(params[:page])
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
  end

  def search
    @q = Wine.search(params[:q])
    @wines = @q.result
    render 'index'
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
      params.require(:wine).permit(:winery, :variety, :color, :vintage, :appellation, :vineyard, :winemaker,
                                   :alcohol_content, :sparkling, :bottle_size, :country, :maturity, :drink_by,
                                   :dessert, :my_notes, :other_notes, :non_vintage,
                                    bottles_attributes: [:id, :purchased_from, :purchase_price, :location,
                                                        :purchase_date, :consumed_date, :_destroy])
    end
end
