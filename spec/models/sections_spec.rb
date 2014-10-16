require 'spec_helper'

RSpec.describe Section, :type => :model do
  it { should have_many :section_teachers }
  it { should have_many :quizzes }
  it { should have_many :teachers }
  it { should have_many :students }
  it { should have_many :standards }
end
