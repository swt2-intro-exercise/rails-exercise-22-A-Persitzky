describe "author page", type: :feature do
    it "Should exist a page for each author" do
        @alan = FactoryBot.create :author

        visit authors_path(@alan)
    end
end