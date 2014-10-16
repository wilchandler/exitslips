require 'spec_helper'

RSpec.describe Enrollment, :type => :model do
  it { should belong_to :section }
  it { should belong_to :student }
end
