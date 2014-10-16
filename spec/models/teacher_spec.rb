require 'spec_helper'

RSpec.describe Teacher, :type => :model do
  it { should have_many :section_teachers }
  it { should have_many :sections }
end
