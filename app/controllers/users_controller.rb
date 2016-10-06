class UsersController < ApplicationController

	before_action except: [:new, :create] { @user = current_user }
	before_action only: [:new, :create] { redirect_back_or root_url if signed_in? }
	before_action :authenticate_user, only: [:edit, :update] ####ДИМАС, СДЕЛАЙ КРАСИВУЮ ДОМАШНЮЮ СТРАНИЦУ ТИПА COOL SHOP

	def new 
		@user = User.new
	end	

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Mega-shop!"
			redirect_back_or root_url
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "success update"
			redirect_to profile_path
		else
			flash[:error] = "error"
			redirect_to edit_user_path
		end
	end

	def destroy
		@user.destroy
		redirect_to users_path, notice: "User deleted."
	end

	private
	
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
