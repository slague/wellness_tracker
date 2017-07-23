require 'rails_helper'

RSpec.feature "User can increment progress for a goal" do
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


    xscenario "user can update progress count with button until total is met" do
      goal = @user.goals.first

# clickon increment_button
     visit user_inc_user_goal_path(goal)

     expect(page).to have_content("1/3")

     visit user_inc_user_goal_path(goal)
     expect(page).to have_content("2/3")

     visit user_inc_user_goal_path(goal)
     expect(page).to have_content("3/3")
     expect(page).to have_content('Nicely done!')
     expect(page).to_not have_content(increment_button)

    end
  end
