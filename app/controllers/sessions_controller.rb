class SessionsController < ApplicationController

	def create
		user = User.find_by(email: user_params[:email].downcase)
		if user && user.authenticate(user_params[:password])
			sign_in user
			flash[:success] = "Welcome, #{user.first_name}!"
			redirect_to user
		else
			flash.now[:error] = "Invalid email or password"
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
