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
    scenario "user can update description" do
      visit edit_user_goal_path(@goal.user, @goal)

      fill_in "goal[description]", with: "Be nicer to Lauren"

      click_on "Update Goal"

      expect(current_path).to eq(user_goals_path(@goal.user))
      expect(page).to have_content('Goal was successfully updated.')
      expect(page).to have_content("Be nicer to Lauren")
    end
    scenario "user can update total goal count" do
      visit edit_user_goal_path(@goal.user, @goal)

      fill_in "goal[total_goal_count]", with: 6

      click_on "Update Goal"

      expect(current_path).to eq(user_goals_path(@goal.user))
      expect(page).to have_content('Goal was successfully updated.')
      expect(page).to have_content("6")
      expect(Goal.find(@goal.id).total_goal_count).to eq(6)
    end
    scenario "user cannot update total goal count to be more than seven" do
      original_goal_count = @goal.total_goal_count

      visit edit_user_goal_path(@goal.user, @goal)

      fill_in "goal[total_goal_count]", with: 8

      click_on "Update Goal"

      expect(page).to have_content("#{@goal.category.name} category's goal sum cannot exceed seven!")
      expect(Goal.find(@goal.id).total_goal_count).to eq(original_goal_count)
    end
    scenario "user cannot update total goal count to be more than seven for a category" do
      user = create(:user_with_goals)
      category = user.goals[0].category
      user.goals[0].update(total_goal_count: 1)
      user.goals[1].update(total_goal_count: 1, category: category)
      user.goals[2].update(total_goal_count: 1, category: category)

      expect(user.goals[2].category_total).to eq(3)

      goal1, goal2, goal3 = user.goals
      original_goal_count = goal1.total_goal_count

      visit edit_user_goal_path(user, goal1)

      fill_in "goal[total_goal_count]", with: 6

      click_on "Update Goal"

      expect(page).to have_content("#{goal1.category.name} category's goal sum cannot exceed seven!")
      expect(Goal.find(goal1.id).total_goal_count).to eq(original_goal_count)
    end
    scenario "user can update progress count with button" do
      original_goal_count = @goal.progress_count

      visit user_goals_path(@goal.user)

      click_button "Increment Goal Progress!"

      expect(page).to have_content('Nicely done!')
      expect(page).to have_content(original_goal_count + 1)
    end
    scenario "user receives achievement messages when goal is met" do
      original_goal_count = @goal.progress_count
      num = @goal.total_goal_count - original_goal_count

      visit user_goals_path(@goal.user)

      num.times do
        click_button "Increment Goal Progress!"
      end

      expect(page).to have_content("You achieved your goal for the week! Awesome job.")
      expect(Goal.find(@goal.id).progress_count).to eq(@goal.total_goal_count)
    end
    scenario "user cannot update progress count if goal has been met" do
      @goal.update(progress_count: @goal.total_goal_count)

      visit user_goals_path(@goal.user)

      expect(page).to_not have_button("Increment Goal Progress!")
    end
  end
end
