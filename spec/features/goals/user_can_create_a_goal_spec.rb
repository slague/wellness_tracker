require 'rails_helper'

RSpec.feature "User can create a goal" do
  context "when providing all information" do
    scenario "they successfully create a goal" do


      
      user = create(:user)
      category = create(:category)
      week = create(:week)

      visit new_user_goal_path(user)

      fill_in "goal[description]", with: "run 3 miles"
      fill_in "goal[total_goal_count]", with: 3
      select category.name, :from=>'goal[category_id]'

      click_on "Create Goal"

      expect(current_path).to eq(user_goals_path(user))
      expect(page).to have_content('Goal was successfully created.')
      expect(page).to have_content("run 3 miles")
    end
  end
end
