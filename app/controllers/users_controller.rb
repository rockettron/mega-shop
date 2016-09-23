class UsersController < ApplicationController

	before_action(except: [:index, :new, :create]) { params[:id] && @user = User.find(params[:id]) }
	before_action :signed_in_user, only: [:edit, :update]
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
		redirect_to root_url, notice: "Please, sign_in..." unless signed_in?
	end

	def correct_user
		redirect_to root_url, notice: "Are you oxuel?" unless current_user?(@user)
	end
end
