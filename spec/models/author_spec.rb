require 'rails_helper'

RSpec.describe Author, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "Should have first_name, last_name, homepage" do
    author = Author.new({:first_name => "Alan", :last_name => "Turing", :homepage =>"https://example.com"})
    expect(author.first_name).to eq("Alan")
    expect(author.last_name).to eq("Turing")
    expect(author.homepage).to eq("https://example.com")

    expect(author.name).to eq("Alan Turing")
  end
end
