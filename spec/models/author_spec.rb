require 'rails_helper'

RSpec.describe Author, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "Should have first_name, last_name, homepage" do
    author = Author.new({:first_name => "Alan", :last_name => "Turing", :homepage => "http://wikipedia.de/Alan_Turing"})
    expect(author.first_name).to eq("Alan")
    expect(author.last_name).to eq("Turing")
    expect(author.homepage).to eq("http://wikipedia.de/Alan_Turing")

    expect(author.name).to eq("Alan Turing")
  end

  it "Should fail with an empty last name" do
    @author = Author.new({:first_name => "Alan"})
    expect(@author).to_not be_valid
  end
end
