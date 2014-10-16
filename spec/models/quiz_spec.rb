require 'spec_helper'

RSpec.describe Quiz, :type => :model do
  it { should belong_to :section }
  it { should have_many :questions }
end
