class CartsController < ApplicationController
	
	before_action :set_cart

	def show
		@cart_items = @cart.cart_items
		render json: @cart_items.as_json  
	end
	
	def check_out
		@cart_items = @cart.cart_items
		p params[user_cart_path]
		if params[user_cart_path]
			@order = @cart.check_out(params[user_cart_path]["adress"])
			redirect_to user_orders_x_path(@order.id, @order.user_id)
		end
	end

	def add_product
		pr = Product.find(params[:product_id].to_i)
		@cart.add_product(pr)
		redirect_to action: 'show'
	end

	def delete_product
		pr = Product.find(params[:product_id].to_i)
		@cart.delete_product(pr) 
		redirect_to action: 'show'
	end

	private

	def set_cart
		if signed_in?
			@cart = current_user.select_active_cart 
		else
			@cart = Cart.find(id: session[:guest_cart_id])
		end
	end
end
