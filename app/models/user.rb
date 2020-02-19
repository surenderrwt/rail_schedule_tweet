class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :validatable
	# belongs_to :role, validate: false
	has_many :tweets
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

	before_validation :in_case_of_last_admin

	def in_case_of_last_admin
		puts self.id
		puts total_activated_admins = User.where("role_id = ? and activate = ?", 2, true).count
		if self.activate_changed?
			if total_activated_admins <= 1  && self.role_id == 2 and self.activate_was == true 
				self.errors.add(:base, message: "Last Admin cannot be updated")
			end
		end
	end

	def is_admin?(user)
		if user.role_id == 2
			true
		else
			return false
		end
	end

	def self.is_admin?
		if self.role_id = "2"
			true
		else
			false
		end		
	end
end