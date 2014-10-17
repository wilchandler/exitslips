require 'spec_helper'

RSpec.describe Section, :type => :model do
  it { should have_many :enrollments }
  it { should have_many :students }
  it { should belong_to :teacher }
  it { should have_many :quizzes }
  it { should have_many :sittings }
  it { should have_many :standards }
end
