class Requirement < ActiveRecord::Base
  belongs_to :section
  belongs_to :standard
end
