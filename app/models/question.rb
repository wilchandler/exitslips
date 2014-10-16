class Question < ActiveRecord::Base
	belongs_to :quiz
	belongs_to :standard
	has_many :options
	has_many :answers
end
