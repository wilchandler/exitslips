require 'spec_helper'

RSpec.describe SectionTeacher, :type => :model do
  it { should belong_to :section }
  it { should belong_to :teacher }
end
