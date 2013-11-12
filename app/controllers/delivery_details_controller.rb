class DeliveryDetailsController < ApplicationController

  before_filter :get_products, :only => [:create,:edit,:update]

  # GET /delivery_details/1/edit
  def edit
    @delivery = Delivery.find(params[:delivery_id])
    @delivery_detail = @delivery.delivery_details.find(params[:id])
  end

  # POST /delivery_details
  # POST /delivery_details.json
  def create
    @delivery = Delivery.find(params[:delivery_id])
    @delivery_detail = @delivery.delivery_details.new(params[:delivery_detail])

    respond_to do |format|
      if @delivery_detail.save
        format.html { redirect_to @delivery, notice: 'Delivery detail was successfully created.' }
        format.json { render json: @delivery_detail, status: :created, location: @delivery_detail }
      else
        format.html { render :template => "deliveries/show" }
        format.json { render json: @delivery_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /delivery_details/1
  # PUT /delivery_details/1.json
  def update
    @delivery = Delivery.find(params[:delivery_id])
    @delivery_detail = @delivery.delivery_details.find(params[:id])

    respond_to do |format|
      if @delivery_detail.update_attributes(params[:delivery_detail])
        format.html { redirect_to @delivery, notice: 'Delivery detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @delivery_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_details/1
  # DELETE /delivery_details/1.json
  def destroy
    @delivery = Delivery.find(params[:delivery_id])
    @delivery_detail = @delivery.delivery_details.find(params[:id])
    @delivery_detail.destroy

    respond_to do |format|
      format.html { redirect_to(@delivery, notice: "Delivery detail was successfully deleted.") }
      format.json { head :no_content }
    end
  end

  private

  def get_products
    @products = Product.select("id,name")
  end
end
