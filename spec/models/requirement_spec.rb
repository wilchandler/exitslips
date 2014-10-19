require 'spec_helper'

describe Requirement do
  it { should belong_to :section }
  it { should belong_to :standard }
  it { should have_many :quizzes }
end
