module SessionsHelper	

	def sign_in(user)
		# User authenticate
		if current_cart.is_empty?
			current_cart.destroy
			self.current_cart = user.select_active_cart
		else
			user.active_cart = current_cart
		end
		session.delete(:cart_token)
		remember_token = User.new_remember_token
		cookies[:remember_token] = { 
			value: remember_token, 
			expires: 1.month.from_now.utc 
		}
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_cart=(cart)
		@current_cart = cart
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by_remember_token(remember_token)
	end

	def current_cart
		@current_cart ||= current_user.select_active_cart if signed_in?	
		@current_cart ||= Cart.find_by_cart_token(session[:cart_token])
	end

	def current_user?(user)
   		user == current_user
    end

	def signed_in?
		!current_user.nil?
	end

	def cart_created?
		!current_cart.nil?
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
		self.current_cart = nil
	end	

	def create_cart
		unless cart_created?
			cart_token = User.new_remember_token
			cart = Cart.create(cart_token: cart_token)
			session[:cart_token] = cart_token
			self.current_cart = cart
		end
	end

	def redirect_back_or(default)
		redirect_to (session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

	#true avtorizacija
	def authenticate_user
		unless signed_in?
			store_location
			redirect_to sign_in_path, notice: "Please, sign_in..." 
		end
	end

end