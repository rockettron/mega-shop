class Cart < ActiveRecord::Base
	belongs_to :user
	has_many :cart_items, dependent: :destroy
	has_many :products, :through => :cart_items

	scope :active, -> { where(status: true) }
	
	def is_empty?
		cart_items.empty?
	end

	def add_product(pr)
		item = CartItem.find_by(product_id: pr.id, cart_id: id)
		if item
			item.quantity += 1
			item.save!
		else
			item = CartItem.create(product_id: pr.id, cart_id: id, price: pr.price)
		end
		item.save!
		item
	end

	def delete_product(pr)
		item = CartItem.find_by(product_id: pr.id, cart_id: id)
		if item 
			if item.quantity > 1
				item.quantity -= 1
				item.save!
			else
				item.destroy
			end
			item
		else
			fail "RecordNotFound"
		end
	end

	def total_items
		cart_items.inject(0) { |count, t| count + t.quantity }
	end

	def total_sum
		cart_items.inject(0) { |sum, t| sum + t.total_price }
	end

	def check_out(adress)
	    item_all = CartItem.where(cart_id: id)
	    order = Order.new(adress: adress, user: user)
	    item_all.each do |item|
	    	order_item = OrderItem.create(product_id: item.product_id, price: item.price, quantity: item.quantity)
	    	order.order_items << order_item
		end
		order.save!
		self.status = false 
		save!
		order
	end

end