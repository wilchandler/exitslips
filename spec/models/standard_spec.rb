require 'spec_helper'

RSpec.describe Standard, :type => :model do
  it { should have_many :sections }
  it { should have_many :quizzes }
end
