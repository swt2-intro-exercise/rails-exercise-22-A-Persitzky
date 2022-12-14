require 'rails_helper'

describe "Paper index page", type: :feature do
  it "should exist an overview over all added papers" do
    # https://guides.rubyonrails.org/routing.html#path-and-url-helpers
    @paper = FactoryBot.create :paper

    visit papers_path

    #expect(page).to have_text "Alan Turing"
    #expect(page).to have_text "http://wikipedia.de/Alan_Turing"
    #expect(page).to have_link "Show", href: author_path(@alan)
    #expect(page).to have_link "New", href: new_author_path
  end

  it "should exist a link to the edit page for the individual papers" do
    @paper = FactoryBot.create :paper

    visit papers_path

    expect(page).to have_link "Edit", href: edit_paper_path(@paper)
  end

  it "Should exist a link to delete a paper" do
    @paper = FactoryBot.create :paper

    visit papers_path

    old_count = Paper.count
    expect(page).to have_link "Delete", href: paper_path(@paper)
    page.find('a', :text => 'Delete', match: :first).click
    expect(old_count).to eq(Paper.count + 1)
  end
end