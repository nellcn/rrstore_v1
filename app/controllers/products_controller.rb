class ProductsController < ApplicationController

  def index
    redirect_to root_path unless signed_in? && current_user.isadmin == 1
    @products = Product.all
  end

  # GET /products/1/edit
  def edit
    redirect_to root_path unless signed_in? && current_user.isadmin == 1
    @product = Product.find(params[:id])
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to store_show_product_path(:id=>@product.id), notice: 'Product was successfully updated.' }
        #format.html { redirect_to store_show_product_path(:id => @product.id), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def product_params
      params.require(:product).permit(:prod_name, :prod_price, :prod_amount, :prod_desc, :prod_img)
    end
end
