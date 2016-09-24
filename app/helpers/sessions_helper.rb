module SessionsHelper

	def sign_in(user)
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
		p @current_user
	end

	def current_user
		p @current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by_remember_token(remember_token)
		if @current_user.nil?
			@current_user = User.find_by(id: session[:guest_user])
		end
	end

	def current_user?(user)
   		user == current_user
    end

	def signed_in?
		!current_user.role.guest?
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
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
			redirect_to sign_in_url, notice: "Please, sign_in..." 
		end
	end

	def correct_user
		redirect_to root_url unless current_user?(@user)
	end

	GUEST_PARAMS = {
  	first_name: "Guest",
  	role: :guest
  }

  def sign_guest
  	if @current_user.nil?
  		current_user = User.new(GUEST_PARAMS)
  		p current_user
  		cart = Cart.create	
  		session[:guest_cart_id] = cart.id
  	end
  end

end