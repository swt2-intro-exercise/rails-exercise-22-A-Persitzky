require 'rails_helper'

describe "Author index page", type: :feature do
  it "should exist an overview over all added athors" do
    # https://guides.rubyonrails.org/routing.html#path-and-url-helpers
    @alan = FactoryBot.create :author

    visit authors_path

    expect(page).to have_text "Alan Turing"
    expect(page).to have_text "http://wikipedia.de/Alan_Turing"
    expect(page).to have_link "Show", href: author_path(@alan)
    expect(page).to have_link "New", href: new_author_path
  end

  it "should exist a link to the edit page for the individual authors" do
    @alan = FactoryBot.create :author

    visit authors_path

    expect(page).to have_link "Edit", href: edit_author_path(@alan)
  end
end