class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
	end


	def after_sign_in_path_for(resource)
		if current_user.activate == false
			reset_session
			flash[:notice] = "Please come back, once your account is approved Sorry for your inconvenience."
			root_path
		else
			if current_user.role.id == 2
				admin_users_path
			else
				root_path
			end
		end
	end

	def authenticated_admin_only
		if current_user.role_id == 1
			flash[:notice] = "unauthorized request " 
			redirect_to controller: "page", action: "index"
		end
	end
end
