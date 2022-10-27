require 'rails_helper'

RSpec.describe Paper, type: :model do
  
  it "Should fail with an empty title" do
    @paper = Paper.new(:venue => "test", :year => 2022)
    expect(@paper).to_not be_valid
  end
  
  it "Should fail with an empty venue" do
    @paper = Paper.new(:title => "Title", :year => 2022)
    expect(@paper).to_not be_valid
  end

  it "Should fail with an empty year" do
    @paper = Paper.new(:title => "Title", :venue => "venue")
    expect(@paper).to_not be_valid
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
