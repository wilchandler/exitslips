class Question < ActiveRecord::Base
	belongs_to :quiz
	belongs_to :standard
	has_many :options
	has_many :answers

  accepts_nested_attributes_for :options, allow_destroy: true
end
