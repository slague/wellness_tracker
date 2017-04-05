require 'rails_helper'

describe "User deletes existing goal" do
  scenario "a user can delete a goal" do
  	user = create(:user_with_goal)
    
    visit user_goals_path(user) 

      click_link "Delete"

    expect(page).to_not have_content(user.goals.first)
    
    within(".flash_success") do
      expect(page).to have_content "Goal Successfully Deleted"
    end
  end
end