class CartItem < ActiveRecord::Base
	belongs_to :cart
	belongs_to :product
	
	def total_price 
		price * quantity
	end

	def increase!(count = 1)
		self.quantity += count
		save!
	end

	def decrease!(count = 1)
		self.quantity > count ? self.quantity -= count : destroy
		save!
	end
end
