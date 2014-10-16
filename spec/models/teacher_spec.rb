require 'spec_helper'

RSpec.describe Teacher, :type => :model do
  it { should have_many :section_teachers }
  it { should have_many :sections }
  it { should validate_presence_of :password }
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_uniqueness_of :email }
end
