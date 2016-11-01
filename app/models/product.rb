class Product < ActiveRecord::Base

	has_many :images, as: :imageable

	validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01, message: 'Некорректная цена' }
	validates :title, uniqueness: true

	scope :top10, -> { top.limit(10) }

	def self.top
		group(:product_id).order('sum(order_items.quantity) DESC').joins(:order_items)
	end
end
