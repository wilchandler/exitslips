class User < ActiveRecord::Base

  self.inheritance_column = :user_type
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :enrollments, foreign_key: :student_id
	has_many :sections, through: :enrollments

  validates :first_name, :last_name, presence: true

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

end
