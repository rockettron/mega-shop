class Admin::ProductsController < Admin::AdminController

	before_action :set_product, except: [:create, :new, :index]

	def index
		@products = Product.all
	end

	def edit
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			redirect_to admin_products_path, notice: "Product is created"
		else
			render :new
		end
	end

	def update
		if @product.update(product_params)
			redirect_to admin_products_path, notice: "Product is updated"
		else 
			render :edit
		end
	end

	def destroy
		@product.destroy
		redirect_to admin_products_path, notice: "Product is deleted"
	end		

private 
	
	def product_params
		params.require(:product).permit(:title, :description, :price)
	end

	def set_product
		@product = Product.find(params[:id])
	end

end
