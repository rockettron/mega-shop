class Order < ActiveRecord::Base
	belongs_to :user, counter_cache: true
	has_many :order_items, dependent: :destroy
	has_many :products, through: :order_items

	validates :address, presence: true

	before_create do
		self.amount = total_sum
		self.items_count = total_items
	end

	def total_items
		order_items.inject(0) { |count, t| count + t.quantity }
	end

	def total_sum
		order_items.inject(0) { |sum, t| sum + t.total_price }
	end

	def users_email
		user.email
	end

	def empty?
		order_items.empty?
    end

    def self.last_order
    	where(created_at: maximum(:created_at)).last
    end

	def self.most_expensive_order
		where(amount: maximum(:amount))
	end

	def self.orders_for_last_period(count_day = 7)
		where(created_at: (Time.now - count_day.day)..Time.now)
	end
end