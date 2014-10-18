class Sitting < ActiveRecord::Base
  belongs_to :student
  belongs_to :quiz
  has_many :answers

  def self.process_response(args={})

  end

end
