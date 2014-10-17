class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :student
  belongs_to :sitting

end
