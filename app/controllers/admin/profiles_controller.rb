class Admin::ProfilesController < Admin::AdminController

	before_action except: [:new, :create] { params[:id] && @user = User.find(params[:id]) }

	def index 
		@users = User.all
	end

	def show
	end

	def destroy
		@user.destroy
		redirect_to admin_profiles_path, notice: "User deleted."
	end

	private 

	def user_params
		params.require(:user).permit(:first_name, :last_name)
	end

end
