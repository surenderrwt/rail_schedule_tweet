class AdminController < ApplicationController
	before_action :set_user, except:[:users]
	before_action :authenticate_user!
	before_action :authenticated_admin_only

	def users
		@users = User.where(["role_id = ?", 1])
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to action: "users"
		end
	end

	def set_user
		@user=   User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :activate)
	end

	private

	def authenticated_admin_only
		if current_user.role_id == 1
			flash[:notice] = "unauthorized request " 
			redirect_to controller: "page", action: "index"
		end
	end
end
