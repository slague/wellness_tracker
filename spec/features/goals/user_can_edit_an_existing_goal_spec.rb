require 'rails_helper'

RSpec.feature "User can edit a goal" do
  context "when providing all information" do
    before :each do
      @category = create :category
      @user = create :user_with_goals

      login(@user)
      visit user_goals_path

      click_on "New Goal"

      fill_in "Description", with: "Run 3 miles"
      fill_in "Total goal count", with: 3
      select @category.name, :from=>'goal[category_id]'

      click_on "Create Goal"
    end

    scenario "user can edit description" do
      visit user_goals_path

      click_link "Edit"

      fill_in "Description", with: "Run 4 miles"

      click_on "Update Goal"
      expect(page).to have_content("Run 4 miles")
      expect(page).to_not have_content("Run 3 miles")
    end

    scenario "user can edit goal count" do
      visit user_goals_path

      click_link "Edit"

      fill_in "Total goal count", with: 4

      click_on "Update Goal"
      expect(page).to have_content("0/4")
      expect(page).to_not have_content("0/3")
    end

    scenario "user cannot change goal category" do
      visit user_goals_path

      click_link "Edit"

      expect(page).to_not have_content("Category")
    end
  end
end
