class Product < ActiveRecord::Base

	has_many :images, as: :imageable

	validates :price, allow_blank: true, numericality: { greater_than_or_equal_to: 0.01, message: 'Некорректная цена' }
	validates :title, uniqueness: true

	scope :top10, -> { top.limit(10) }

	def info
		"#{self.title} - #{self.description}" 
	end

	def price_string
		"#{self.price}$"
	end

	def self.most_expensive_product
		order(:price => :desc).limit(1)
	end

	def self.most_cheap_product
		order(:price => :asc).limit(1)
	end

	def self.top
		group(:product_id).order('sum(order_items.quantity) DESC').joins(:order_items)
	end
end
