class Admin::UsersController < Admin::AdminController
	def index
		@users = User.all
	end

	def destroy
		@user.destroy
		redirect_to users_path, notice: "User deleted."
	end
	
end
