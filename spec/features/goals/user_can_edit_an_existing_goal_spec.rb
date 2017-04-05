require 'rails_helper'

RSpec.feature "User can edit a goal" do
  context "when providing all information" do
    before :each do
      @goal = create(:goal)
    end
    scenario "user can click edit" do
      visit user_goals_path(@goal.user)

      click_link "Edit"

      expect(current_path).to eq(edit_user_goal_path(@goal.user, @goal))
      expect(page).to_not have_content("Category")
    end
    xscenario "user can update description" do
      visit edit_user_goal_path(@goal.user, @goal)

      fill_in "goal[description]", with: "Be nicer to Lauren"

      click_on "Update Goal"

      expect(current_path).to eq(user_goals_path(@goal.user))
      expect(page).to have_content('Goal was successfully updated.')
      expect(page).to have_content("Be nicer to Lauren")
    end
    xscenario "user can update total goal count" do
      visit edit_user_goal_path(@goal.user, @goal)

      fill_in "goal[total_goal_count]", with: 6

      click_on "Update Goal"

      expect(current_path).to eq(user_goals_path(@goal.user))
      expect(@goal.total_goal_count).to eq(6)
      expect(page).to have_content('Goal was successfully updated.')
      expect(page).to have_content("6")
    end
    xscenario "user cannot update total goal count to be more than seven" do
      original_goal_count = @goal.total_goal_count

      visit edit_user_goal_path(@goal.user, @goal)

      fill_in "goal[total_goal_count]", with: 8

      click_on "Update Goal"

      expect(page).to have_content('Goal cannot be more than seven.')
      expect(@goal.total_goal_count).to eq(original_goal_count)
    end
    xscenario "user cannot update total goal count to be more than seven for a category" do
      user = create(:user_with_goals)
      category = user.goals[0].category
      user.goals[0].update(total_goal_count: 1)
      user.goals[1].update(total_goal_count: 1, category: category)
      user.goals[2].update(total_goal_count: 1, category: category)

      expect(user.goal_total(category)).to eq(3)

      goal1, goal2, goal3 = user.goals

      original_goal_count = goal1.total_goal_count

      visit edit_user_goal_path(user, goal1)

      fill_in "goal[total_goal_count]", with: 5

      click_on "Update Goal"

      expect(page).to have_content('You cannot have more than seven goals for #{category.name}.')
      expect(goal1.total_goal_count).to eq(original_goal_count)
    end
    xscenario "user can update progress count with button" do
      original_goal_count = @goal.progress_count

      visit user_goals_path(@goal.user)

      click_button "Increment Goal Progress!"

      expect(page).to have_content('Good job!')
      expect(page).to have_content(original_goal_count + 1)
    end
    xscenario "user cannot update progress count if goal has been met" do
      @goal.update(progress_count: total_goal_count)

      visit user_goals_path(@goal.user)

      expect(page).to_not have_button("Increment Goal Progress!")
    end
  end
end
