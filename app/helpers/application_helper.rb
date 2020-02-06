module ApplicationHelper

	def twitter_authenticate_status
		if current_user 
			if current_user.access_token.nil?
				'<h3> Disconnected</h3>'.html_safe
			else
				'<h3> Connected </h3>'.html_safe
			end
		end 
	end

	def link_to_twitter_authenticate
		if current_user
			if current_user.access_token.nil?
				link_to "Login with twitter", "oauth/request"
			end
		end
	end

	def active_class(link_path)
		current_page?(link_path) ? "active" : ""	
	end

	def user_navigation
		if current_user && current_user.role_id == 1
			render "layouts/user_nav"

		elsif current_user && current_user.role_id == 2
			render "layouts/admin_nav"
			
		else
			render "layouts/visitor_nav"
		end		
	end
end
