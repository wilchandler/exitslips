require 'spec_helper'

RSpec.describe Answer, :type => :model do
  it { should belong_to :question }
  it { should belong_to :student }
  it { should belong_to :sitting }
end
