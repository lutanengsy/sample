class OrderDetailsController < ApplicationController

  before_filter :get_products, :only => [:create,:edit,:update]

  # GET /order_details/1/edit
  def edit
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
  end

  # POST /order_details
  # POST /order_details.json
  def create
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.new(params[:order_detail])

    respond_to do |format|
      if @order_detail.save
        format.html { redirect_to @order, notice: 'Order detail was successfully created.' }
        format.json { render json: @order_detail, status: :created, location: @order_detail }
      else
        format.html { render :template => "orders/show" }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_details/1
  # PUT /order_details/1.json
  def update
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])

    respond_to do |format|
      if @order_detail.update_attributes(params[:order_detail])
        format.html { redirect_to @order, notice: 'Order detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_details/1
  # DELETE /order_details/1.json
  def destroy
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
    @order_detail.destroy

    respond_to do |format|
      format.html { redirect_to @order, notice: "Order detail was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def get_products
    @products = Product.select("id,name")
  end
end
