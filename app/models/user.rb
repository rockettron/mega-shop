class User < ActiveRecord::Base
	extend Enumerize 
	enumerize :role, in: [:admin, :moderator, :user], default: :user
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_one :profile, dependent: :destroy
	has_many :carts, dependent: :destroy
	has_many :orders, dependent: :destroy
	has_one :profile, dependent: :destroy

	has_secure_password

	validates :password, length: { minimum: 6 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

	after_create :create_cart_for_user
	before_create :create_remember_token
	before_save ->{ email.downcase! }

	def full_name
		profile.nil? ? email : profile.full_name
	end

	def select_active_cart
		carts.active.last
	end

	def active_cart=(cart)
		carts.active.each { |c| c.update_attribute(:status, false) }
		cart.update_attributes(user_id: id, status: true)
	end

	def superuser?
		self.role.moderator? || self.role.admin?
	end

    def self.most_active_user_for_period(count_day = 7)
    	relation = where("orders.created_at >= ?", Time.now - count_day.day).group('users.id').joins(:orders)
    	relation.having("count(*) = ?", relation.count.values.max)
    end

    def self.new_remember_token
    	SecureRandom.urlsafe_base64
    end

    def self.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
    end

  private 

	def create_cart_for_user
		Cart.create(user: self, cart_token: SecureRandom.urlsafe_base64)
	end

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
	
end
