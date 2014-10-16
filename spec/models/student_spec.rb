require 'spec_helper'

RSpec.describe Student, :type => :model do
  it { should have_many :sections }
  it { should have_many :answers }
end
