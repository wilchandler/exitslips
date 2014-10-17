require 'spec_helper'

RSpec.describe Sitting, :type => :model do
  it { should belong_to :student }
  it { should belong_to :quiz }
  it { should have_many :answers }
end
