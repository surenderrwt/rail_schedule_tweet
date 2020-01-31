class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  end


  def after_sign_in_path_for(resource)
  	if current_user.activate == false
  		# destroy_user_session_path(current_user)
  		# sign_out current_user
  		session.delete(current_user)
  		flash[:notice] = " Your account is not activated"
  		admin_users_path
  	else
  	  if current_user.role.id == 2
		     admin_users_path
	  	else
	    	tweets_path
	  	end
	  end
	end

end
