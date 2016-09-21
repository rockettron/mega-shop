class ProductsController < ApplicationController

	def index
		@products = Product.all
		respond_to do |format|
    		format.html
    		format.json { render json: @products.as_json(only: [:id, :title, :description, :price], include: [:orders]) }
  		end
	end

	def new 
		@product = Product.new
	end	

	def create
		@product = Product.new(product_params)
		if @product.save
			redirect_to @product
		else
			render action: 'new'
		end
	end

	def edit
		@product = Product.find(params[:id]) 
	end

	def show
		@product = Product.find(params[:id])
		respond_to do |f|
			f.html
			f.json { render json: @product.as_json(include: [:orders, :order_items])}
		end
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			redirect_to @product
		else
			render :edit
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to :products
	end

	def top10
		@products = Product.top10
		render json: @products.as_json(include: :order_items)
	end

	private

	def product_params
		params.require(:product).permit(:title, :description, :price)  #в чем разница, если писать без require?
		#Объяснить метод permit
	end
end
