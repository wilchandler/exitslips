
require 'spec_helper'


Describe "Teacher" do

  before :each do
  	teacher = FactoryGirl.create(:teacher)
  	login_as(teacher, :scope => :teacher)
  end

end

