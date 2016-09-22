class UsersController < ApplicationController

	before_action(except: [:index, :new, :create]) { params[:id] && @user = User.find(params[:id]) }

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
end
