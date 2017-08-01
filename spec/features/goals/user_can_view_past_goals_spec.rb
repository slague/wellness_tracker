require "rails_helper"

describe "User can see all past goals" do
  before do
    Category.create(id: 1, name: "Category")
    WeekNumber.create(id: 1, name: "Week 1")
    WeekNumber.create(id: 2, name: "Week 2")
    WeekNumber.create(id: 3, name: "Week 3")
    WeekNumber.create(id: 4, name: "Week 4")
    WeekNumber.create(id: 5, name: "Week 5")
    WeekNumber.create(id: 6, name: "Week 6")

    @last_mod = Mod.create(inning: "1706")

    @last_mod.weeks.create(id: 1, start_date: "2017-06-26", end_date: "2017-07-02", week_number_id: 1)
    @last_mod.weeks.create(id: 2, start_date: "2017-07-03", end_date: "2017-07-09", week_number_id: 2)
    @last_mod.weeks.create(id: 3, start_date: "2017-07-10", end_date: "2017-07-16", week_number_id: 3)
    @last_mod.weeks.create(id: 4, start_date: "2017-07-17", end_date: "2017-07-23", week_number_id: 4)
    @last_mod.weeks.create(id: 5, start_date: "2017-07-24", end_date: "2017-07-30", week_number_id: 5)
    @this_week = @last_mod.weeks.create(id: 6, start_date: "2017-07-31", end_date: "2017-08-06", week_number_id: 6)


    @user1 = User.create(github_id: 1, name: "A Student", cohort: "1701")
    @user1.goals.create(description: "1111", category_id: 1, week_id: 1, progress_count: 1, total_goal_count: 2)
    @user1.goals.create(description: "2222", category_id: 1, week_id: 2, progress_count: 2, total_goal_count: 2)
    @user1.goals.create(description: "3333", category_id: 1, week_id: 3, progress_count: 2, total_goal_count: 2)
    @user1.goals.create(description: "4444", category_id: 1, week_id: 4, progress_count: 2, total_goal_count: 2)
    @user1.goals.create(description: "5555", category_id: 1, week_id: 5, progress_count: 2, total_goal_count: 2)
    @user1.goals.create(description: "6666", category_id: 1, week_id: 6, progress_count: 2, total_goal_count: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    allow_any_instance_of(ApplicationController).to receive(:current_week).and_return(@this_week)
  end

  scenario "a user can visit past goals link" do

    visit user_goals_path

    expect(page).to have_link("Past goals")
  end

  scenario "visits past goals link and sees past goals" do

    visit user_goals_path

    click_on "Past goals"

    expect(current_path).to eq(user_path(@user1))
    expect(page).to have_content("My Past Goals")
    expect(page).to have_content("1111")
    expect(page).to have_content("1 / 2")
    expect(page).to have_content("2222")
    expect(page).to have_content("3333")
    expect(page).to have_content("4444")
    expect(page).to have_content("5555")
  end

end
