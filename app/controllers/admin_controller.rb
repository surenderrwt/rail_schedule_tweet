class AdminController < ApplicationController
	before_action :set_user, except:[:users]
	before_action :authenticate_user!
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

end
