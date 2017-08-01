require "rails_helper"

describe "User can see current week community progress" do
  before do
    Category.create(id: 1, name: "Category 1")
    Category.create(id: 2, name: "Category 2")
    Category.create(id: 3, name: "Category 3")
    Category.create(id: 4, name: "Category 4")

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
    @user1.goals.create(description: "1111", category_id: 1, week_id: 6, progress_count: 1, total_goal_count: 2)
    @user1.goals.create(description: "2222", category_id: 2, week_id: 6, progress_count: 1, total_goal_count: 2)

    @user2 = User.create(github_id: 1, name: "B Student", cohort: "1701")
    @user2.goals.create(description: "3333", category_id: 3, week_id: 6, progress_count: 1, total_goal_count: 3)
    @user2.goals.create(description: "4444", category_id: 4, week_id: 6, progress_count: 1, total_goal_count: 2)

    @user3 = User.create(github_id: 1, name: "C Student", cohort: "1701")
    @user3.goals.create(description: "1111", category_id: 1, week_id: 6, progress_count: 1, total_goal_count: 2)
    @user3.goals.create(description: "2222", category_id: 2, week_id: 6, progress_count: 1, total_goal_count: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    allow_any_instance_of(ApplicationController).to receive(:current_week).and_return(@this_week)
  end

  scenario "a user can visit Turing Totals link" do

    visit user_goals_path

    expect(page).to have_link("Turing Totals")
  end

  scenario "visits Turing Totals and sees current community progress" do

    visit user_goals_path

    click_on "Turing Totals"

    expect(current_path).to eq(goals_path)

    expect(page).to have_content("This Week's Turing Community Totals")

    expect(page).to have_content("Category 1")
    expect(page).to have_content("2 / 4")
    expect(page).to have_content("Category 2")
    expect(page).to have_content("2 / 4")
    expect(page).to have_content("Category 3")
    expect(page).to have_content("1 / 3")
    expect(page).to have_content("Category 4")
    expect(page).to have_content("1 / 2")
  end

end
