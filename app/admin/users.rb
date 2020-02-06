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
  		puts no_of_admins = User.where("role_id = ? and activate = ?", 2, true).count
  		if resource.role_id == 2 && no_of_admins <= 1
  			redirect_to admin_users_path, notice: "Cannot Deactivate last Admin"
  		else
  			resource.update(activate: false)
  			redirect_to admin_users_path, notice: "User deactivated!"
  		end
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
  		column :role_id
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
  		permitted = [:email,:encrypted_password, :role_id, :activate, :access_token, :access_token_secret, :full_name]
  		permitted << :other if params[:action] == 'create' && current_user.admin?
  		permitted
  	end

  	config.comments = false

  end
