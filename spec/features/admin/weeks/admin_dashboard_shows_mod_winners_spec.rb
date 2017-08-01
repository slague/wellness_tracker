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

    @last_mod = Mod.create(inning: "1705")
    @last_mod.weeks.create(start_date:"2017-05-01", end_date: "2017-05-08", week_number_id: 1)
    @mod = Mod.create(inning: "1706")

    @last_week = @mod.weeks.create(start_date: "2017-06-26", end_date: "2017-07-02", week_number_id: 1)
    @this_week = @mod.weeks.create(start_date: "2017-07-03", end_date: "2017-07-09", week_number_id: 2)

    @user1 = User.create(github_id: 1, name: "A Student", cohort: "1701")
    @user1.goals.create(description: "1111", category_id: 1, week_id: @last_week.id, progress_count: 2, total_goal_count: 2)
    @user1.goals.create(description: "1111", category_id: 1, week_id: @this_week.id, progress_count: 2, total_goal_count: 2)

    @user1.goals.create(description: "last mod goal", category_id: 1, week_id: @last_mod.weeks.first.id, progress_count: 2, total_goal_count: 2)

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

  scenario "can see users on track to be mod winners" do
    visit admin_dashboard_index_path

    within(all(:css, 'ul li').last) do
      click_on "Mod Winners"
    end

    within(:css, 'div#mod-winners') do
      expect(page).to have_content("Students on track so far this Mod:")

      expect(page).to have_content("A Student")
      expect(page).to_not have_content("B Student")
      expect(page).to_not have_content("C Student")
    end
  end

  scenario "can see current mod's past weekly winners" do
    visit admin_dashboard_index_path

    within(all(:css, 'ul li').last) do
      click_on "Mod Winners"
    end

    within(:css, 'div#mod-winners') do
      expect(page).to have_button("Past Mod Winners")
    end

    within(:css, 'div#mod-winners') do
      click_on "Past Mod Winners"
    end

    expect(current_path).to eq(mods_path)
    expect(page).to have_content("A Student, 1701")

  end
end
