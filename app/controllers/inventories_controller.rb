class InventoriesController < ApplicationController

  def index
    @products = Product.all
    @totals   = @products.to_a.sum{|product| product.subtotal }

    respond_to do |format|
      format.html
      format.json {render json: @products}
    end
  end

  def show
    @product = Product.find(params[:id])
    @inventories = @product.inventories.all    
    
    respond_to do |format|
      format.html
      format.json {render json: @products}
    end
  end
end
