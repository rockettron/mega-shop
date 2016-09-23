class User < ActiveRecord::Base
	#extend Enumerize 

	#enumerize :role, in: [:admin, :redactor, :guest, :user], default: :guest
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_many :carts, dependent: :destroy
	has_many :orders, dependent: :destroy

	has_secure_password

	validates :first_name, :last_name, presence: true
	validates :password, length: { minimum: 6 }
	validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

	after_create :create_cart_for_user
	before_create :create_remember_token
	before_save ->{ email.downcase! }

	def full_name
		"#{first_name} #{last_name}"
	end

	def replenish_balance(money)
		self.update_attributes(balance: self.balance + money)
	end

	def change_password(old_password, new_password)
		if password == old_password
			password = new_password
			save
		else
			false
		end
	end

	def self.authenticate(email, password)
		user = where(email: email, password: password).first
		return false if user.nil?
		user
	end

	def select_active_cart
		carts.active.first
	end

	def count_orders
		orders.count
	end

    def total_cost_orders
    	orders.pluck(:amount).reduce(:+)
    end

	def self.most_active_user 
    	where(orders_count: maximum(:orders_count))
    end

    def self.most_active_user_for_period(count_day = 7)
    	relation = where("orders.created_at >= ?", Time.now - count_day.day).group('users.id').joins(:orders)
    	relation.having("count(*) = ?", relation.count.values.max)
    end

    def self.user_of_last_order
    	find(Order.last_order.user_id)	
    end

    def self.user_of_most_expensive_order
    	Order.most_expensive_order.map { |order| find(order.user_id) }.uniq
    end

    def self.user_of_bigest_order
    	Order.bigest_order.map { |order| find(order.user_id) }.uniq
    end

    def self.new_remember_token
    	SecureRandom.urlsafe_base64
    end

    def self.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
    end

  private 

	def create_cart_for_user
		Cart.create(user: self)
	end

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end

end
