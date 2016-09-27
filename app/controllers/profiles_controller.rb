class ProfilesController < ApplicationController

	before_action :authenticate_user

	def new
		@profile = Profile.new
	end

	def create
		@profile = Profile.new(profile_params)
		@profile.user = current_user
		if @profile.save
			redirect_to @profile, notice: "Profile is created"
		else 
			render :new
		end
	end

	def show
		@profile = Profile.find_by(user: current_user)
	end

	def update
	end

	def destroy
		@user.destroy
		redirect_to admin_profiles_path, notice: "User deleted."
	end

	private 

	def profile_params
		params.require(:profile).permit(:first_name, :last_name)
	end

end
