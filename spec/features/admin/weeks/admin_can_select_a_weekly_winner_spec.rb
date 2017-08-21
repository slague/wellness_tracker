require 'rails_helper'

RSpec.feature "When a logged in admin visits dashboard" do

  before do
    Category.create(id: 1, name: "Category")
    WeekNumber.create(id: 1, name: "Week 1")
    WeekNumber.create(id: 2, name: "Week 2")
    WeekNumber.create(id: 3, name: "Week 3")
    WeekNumber.create(id: 4, name: "Week 4")
    WeekNumber.create(id: 5, name: "Week 5")
    WeekNumber.create(id: 6, name: "Week 6")

    @mod = Mod.create(inning: "1701")
    @mod2 = Mod.create(inning: "1703")
    @mod3 = Mod.create(inning: "1705")

    @last_week = @mod.weeks.create(start_date: "2017-06-26", end_date: "2017-07-02", week_number_id: 1)
    @this_week = @mod.weeks.create(start_date: "2017-07-03", end_date: "2017-07-09", week_number_id: 2)
    @mod.weeks.create(start_date: "2017-07-10", end_date: "2017-07-16", week_number_id: 3)
    @mod.weeks.create(start_date: "2017-07-17", end_date: "2017-07-23", week_number_id: 4)
    @mod.weeks.create(start_date: "2017-07-24", end_date: "2017-07-30", week_number_id: 5)
    @mod.weeks.create(start_date: "2017-07-31", end_date: "2017-08-06", week_number_id: 6)

    @user1 = User.create(github_id: 1, name: "A Student", cohort: "1701")
    @user1.goals.create(description: "1111", category_id: 1, week_id: @this_week.id, progress_count: 2, total_goal_count: 2)
    @user1.goals.create(description: "1111", category_id: 1, week_id: @last_week.id, progress_count: 2, total_goal_count: 2)

    @last_week_winner = Winner.create(user_id: @user1.id, week_id: @last_week.id)

    @user2 = User.create(github_id: 2, name: "B Student", cohort: "1702")
    @user2.goals.create(description: "2222", category_id: 1, week_id: @this_week.id, progress_count: 2, total_goal_count: 2)
    @user3 = User.create(github_id: 3, name: "C Student", cohort: "1703")
    @user3.goals.create(description: "3333", category_id: 1, week_id: @this_week.id, progress_count: 2, total_goal_count: 4)

    @admin = create(:user)
    @admin.update(role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    allow_any_instance_of(ApplicationController).to receive(:current_week).and_return(@this_week)
  end

  scenario "can see users who have achieved 100% of goals this week" do
    visit admin_dashboard_index_path

    click_on "Weekly Winners"

    expect(page).to have_content("Achieved 100% of goals this week:")
    expect(page).to have_content("A Student, 1701")
    expect(page).to have_content("B Student, 1702 ")
    expect(page).to_not have_content("C Student")

  end

  scenario "can see current mod's past weekly winners" do
    visit admin_dashboard_index_path

    click_on "Weekly Winners"

    expect(page).to have_content("This Mod's Weekly Winners")
    expect(page).to have_content("Week 1: A Student, 1701")
    expect(page).to have_content("Week 2: No winner selected yet")
  end

  scenario "can only select a weekly winner for weeks that are complete and do not already have a winner" do
    visit admin_dashboard_index_path

    click_on "Weekly Winners"

    expect(page).to have_button("Select a winner!")

    expect(page).to have_content("Week")
    expect(page).to have_select("week_id", options: ["2017-07-03", "2017-07-10", "2017-07-17", "2017-07-24", "2017-07-31"])
    expect(page).to_not have_select("week_id", options: ["2017-06-26"])
  end

  scenario "can click select a winner and randomly choose a winner for the set week" do
    visit admin_dashboard_index_path

    click_on "Weekly Winners"

    select('2017-07-03', :from => 'Week')
    click_on "Select a winner!"

    expect(page).to have_content("is the winner this week!")
  end
end
