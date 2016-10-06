class UsersController < ApplicationController

	before_action :authenticate_user, only: [:edit, :update] ####ДИМАС, СДЕЛАЙ КРАСИВУЮ ДОМАШНЮЮ СТРАНИЦУ ТИПА COOL SHOP
	before_action except: [:new, :create] { @user = current_user }
	before_action only: [:new, :create] { redirect_back_or root_url if signed_in? }
	
	#before_action :correct_user, only: [:edit, :update]

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
			redirect_to @user
		else
			render :edit
		end
	end


	private
	
	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
