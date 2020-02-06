ActiveAdmin.register User do

  	# See permitted parameters documentation:
  	# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  	#
  	# Uncomment all parameters which should be permitted for assignment
  	#
  	# permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :role_id, :activate, :remember_created_at, :access_token, :access_token_secret, :full_name
  	#
  	# or
  	#
  	menu priority: 2

  	member_action :activate, method: :get do
  		resource.update(activate: true)
  		redirect_to admin_users_path, notice: "User Activated!"
  	end

  	member_action :deactivate, method: :get do
  		resource.update(activate: false)
  		redirect_to admin_users_path, notice: "User deactivated!"
  	end

  	action_item :revoke, only: :show do
  		if user.activate? 
  			link_to 'Deactivate', deactivate_admin_user_path(user), method: :get 
  		else
  			link_to 'Activate', activate_admin_user_path(user), method: :get
  		end
  	end

  	index do
  		selectable_column
  		id_column
  		column :full_name
  		column :email
  		column :activate
  		column :access_token
  		column :access_token_secret
  		column :created_at
  		column :updated_at
  		actions { |user| 
  			if user.activate? 
  				link_to 'Deactivate', deactivate_admin_user_path(user), method: :get 
  			else
  				link_to 'Activate', activate_admin_user_path(user), method: :get
  			end  
  		} 
  	end
  	
  	
  	permit_params do
  		permitted = [:email, :role_id, :activate, :access_token, :access_token_secret, :full_name]
  		permitted << :other if params[:action] == 'create' && current_user.admin?
  		permitted
  	end

  	config.comments = false
  	
  end
