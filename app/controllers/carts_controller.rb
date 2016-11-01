class CartsController < ApplicationController
	
	before_action :set_cart

	def show
		@cart_items = @cart.cart_items
		#render json: @cart_items.as_json  
	end

	private

	def set_cart
		@cart = current_cart
	end
end
