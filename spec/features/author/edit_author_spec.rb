describe "Edit author page", type: :feature do
    it "Should exist a page to edit authors" do
        @author = FactoryBot.create :author

        visit edit_author_path(@author)
        fill_in "author[first_name]", with: "Bob"
        click_button('Update Author')
        @author.reload

        expect(@author.first_name).to eq("Bob")
        

    end
end