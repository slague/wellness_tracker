require "rails_helper"

describe "User sees all goals" do
  scenario "a user sees all his/her goals" do
    user      = create(:user_with_goals)
    goal_one, goal_two, goal_three = user.goals

    visit user_goals_path(user)

    expect(page).to have_content goal_one.progress_count
    expect(page).to have_content goal_one.total_goal_count
    expect(page).to have_content goal_one.category_id
    expect(page).to have_content goal_two.description
    expect(page).to have_content goal_three.category_id

  end
end
