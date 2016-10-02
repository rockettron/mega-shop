class ProfilesController < ApplicationController

	before_action :authenticate_user
	before_action :set_profile, except: [:new, :create]

	def new
		@profile = Profile.new
	end

	def create
		@profile = Profile.new(profile_params)
		@profile.user = current_user
		if @profile.save
			redirect_to profile_path, notice: "Profile is created"
		else 
			render :new
		end
	end

	def show
		redirect_to new_profile_path unless @profile
	end

	def edit
	end

	def update
		if @profile.update(profile_params)
			redirect_to profile_path, notice: "Profile is updated"
		else
			render :edit
		end
	end

	def destroy
		@profile.destroy
		redirect_to root_path, notice: "User deleted."
	end

	private 

	def profile_params
		params.require(:profile).permit(:first_name, :last_name)
	end

	def set_profile
		@profile ||= Profile.find_by(user: current_user)
	end

end
