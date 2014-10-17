require 'spec_helper'

RSpec.describe Student, :type => :model do
  it { should have_many :sections }
  it { should have_many :enrollments }
  it { should have_many :answers }
  it { should have_many :sittings }
  it { should have_many :quizzes }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end
