class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :student, class_name: "User"
end
