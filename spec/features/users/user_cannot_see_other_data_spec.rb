require 'rails_helper'


RSpec.feature "user cannot view others' data" do
  scenario "a logged in user cannot see other user's current goals" do
      Category.create(id: 1, name: "Category")
      week = create(:week)
      user = User.create(github_id: 1, name: "Student", cohort: "1701")
      user.goals.create(week_id: week.id, category_id: 1, description: "test", total_goal_count: 4)
      user2 = User.create(github_id: 2, name: "Student 2", cohort: "1701")
      user2.goals.create(week_id: week.id, category_id: 1, description: "something else", total_goal_count: 4)
      allow_any_instance_of(ApplicationController).to receive(:current_week).and_return(week)
      login(user)

      visit user_goals_path

      expect(page).to have_content(user.name)
      expect(page).to_not have_content(user2.name)
  end

  scenario "a regular user cannot visit the admin dashboard" do
      user = create(:user)
      login(user)

      visit admin_dashboard_index_path

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
      expect(page).to_not have_content("Admin Dashboard")
  end

end
