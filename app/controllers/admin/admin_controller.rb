class Admin::AdminController < ApplicationController
	before_action :authenticate_user
	before_action :only_super_user

	def root 
	end

  private 

  def only_super_user
  	if !current_user.superuser?
  		redirect_to root_path, notice: "Your profile isn't admin or moderator"
  	end
  end

end
