class Sitting < ActiveRecord::Base
  belongs_to :student
  belongs_to :quiz
  has_many :answers

  def self.average_sittings(sittings = [])
    return nil if sittings.empty?

    percentages = sittings.map { |sitting| sitting.calculate_percentage }
    (percentages.inject(:+).to_f / percentages.length.to_f).round
  end

  def calculate_percentage
    (self.correct.to_f / self.possible.to_f * 100).round
  end
end
