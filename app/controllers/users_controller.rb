class UsersController < ApplicationController

	before_action except: [:index, :new, :create] { params[:id] && @user = User.find(params[:id]) }
	before_action only: [:new, :create] { redirect_back_or root_url if signed_in? }
	before_action :signed_in_user, only: [:index, :edit, :update] ####ДИМАС, СДЕЛАЙ КРАСИВУЮ ДОМАШНЮЮ СТРАНИЦУ ТИПА COOL SHOP
	before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all
	end

	def new 
		@user = User.new
	end	

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Mega-shop!"
			redirect_to @user  
		else
			render :new
		end
	end

	def edit
	end

	def show
	end

	def update
		if @user.update(user_params)
			redirect_to @user
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		redirect_to :users
	end

	def replenish_balance
		if params[:user] 
			add = params.require(:user)[:balance]
			@user.replenish_balance(add.to_i)
		end
	end

	private
	
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
#true avtorizacija
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to sign_in_url, notice: "Please, sign_in..." 
		end
	end

	def correct_user
		redirect_to root_url unless current_user?(@user)
	end
end
