describe "Paper page", type: :feature do
    it "Should list the authors of the paper" do
        @paper = FactoryBot.create :paper
        @author = FactoryBot.create :author
        visit authors_path(@paper)
        expect(page).to have_text(@author.name)

    end
end