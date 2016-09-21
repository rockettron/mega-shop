class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product

	def total_price 
		price * quantity
	end
end
