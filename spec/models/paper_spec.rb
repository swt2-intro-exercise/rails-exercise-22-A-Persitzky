require 'rails_helper'

RSpec.describe Paper, type: :model do
  
  it "Should fail with an empty title" do
    @paper = Paper.new
    expect(@paper).to_not be_valid
  end
  
  pending "add some examples to (or delete) #{__FILE__}"
end
