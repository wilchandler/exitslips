require 'spec_helper'

RSpec.describe Question, :type => :model do
  it { should have_many :answers }
  it { should have_many :options }
  it { should belong_to :standard }
  it { should belong_to :quiz }
end
