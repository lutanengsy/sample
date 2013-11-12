class OrdersController < ApplicationController
  before_filter 'get_customers', :only => ['new','create','edit','update']
  before_filter 'get_products',  :only => ['show']

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.order("id").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.includes([:customer,:order_details => :product]).find(params[:id])
    
    if !@order.delivered?
      @order_detail = @order.order_details.new
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    
    begin
      @order.destroy
      message = "Order was successfully deleted."
    rescue ActiveRecord::DeleteRestrictionError => e
      #@order.errors.add(:base, e)
      message = "Order is still in use. Unable to delete order. "
    end

    respond_to do |format|
      format.html { redirect_to orders_url, notice: message }
      format.json { head :no_content }
    end
  end

  def deliver
    order = Order.find(params[:id])
    order.deliver!
    redirect_to orders_url, notice: "Order was successfully delivered."
  end

  private

  def get_customers
    @customers = Customer.select("id,name")
  end

  def get_products
    @products = Product.select("id,name")
  end
end
