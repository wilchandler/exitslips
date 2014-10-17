require 'spec_helper'

RSpec.describe Quiz, :type => :model do
  it { should belong_to :standard }
  it { should have_many :sittings }
  it { should have_many :students }
  it { should belong_to :section }
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :options }
end
