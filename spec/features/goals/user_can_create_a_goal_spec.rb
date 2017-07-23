require 'rails_helper'

RSpec.feature "User can create a goal" do
  context "when providing all information" do
    scenario "they click new goal, fill out form, and click create goal and goal is saved" do

      user = create(:user)
      category = create(:category)
      login(user)

      visit user_goals_path
      expect(page).to have_link("New Goal")

      click_on "New Goal"

      expect(current_path).to eq(new_user_goal_path)

      fill_in "Description", with: "Run 3 miles"
      fill_in "Total goal count", with: 3
      select category.name, :from=>'goal[category_id]'

      click_on "Create Goal"

      expect(current_path).to eq(user_goals_path)
      expect(page).to have_content('Goal was successfully created.')
      expect(page).to have_content("Run 3 miles")
    end
  end
end
