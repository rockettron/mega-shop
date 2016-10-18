class SessionsController < ApplicationController
	before_action only: [:new, :create] { redirect_back_or root_url if signed_in? }

	def new
	end

	def create	
		user = User.find_by(email: user_params[:email].downcase)
		if user && user.authenticate(user_params[:password])
			sign_in user
			redirect_back_or profile_path
		else
			flash.now[:danger] = "Invalid email or password"
			render :new
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

  private
  	def user_params
  		params.require(:session).permit(:email, :password)
  	end

end

# I love Lizka 