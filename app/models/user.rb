class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    belongs_to :role
    has_many :tweets

    def is_admin?(user)
    	if user.role_id == 2
    		true
    	else
    		return false
    	end
    end
end
