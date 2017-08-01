require 'rails_helper'

RSpec.feature "User can increment progress for a goal" do
  before do
    Category.create(id: 1, name: "Category")

    WeekNumber.create(id: 1, name: "Week 1")
    WeekNumber.create(id: 2, name: "Week 2")
    WeekNumber.create(id: 3, name: "Week 3")
    WeekNumber.create(id: 4, name: "Week 4")
    WeekNumber.create(id: 5, name: "Week 5")
    WeekNumber.create(id: 6, name: "Week 6")

    @mod = Mod.create(inning: "1701")

    @this_week = @mod.weeks.create(start_date: "2017-06-26", end_date: "2017-07-02", week_number_id: 1)
    @mod.weeks.create(start_date: "2017-07-03", end_date: "2017-07-09", week_number_id: 2)
    @mod.weeks.create(start_date: "2017-07-10", end_date: "2017-07-16", week_number_id: 3)
    @mod.weeks.create(start_date: "2017-07-17", end_date: "2017-07-23", week_number_id: 4)
    @mod.weeks.create(start_date: "2017-07-24", end_date: "2017-07-30", week_number_id: 5)
    @mod.weeks.create(start_date: "2017-07-31", end_date: "2017-08-06", week_number_id: 6)

    @user = create(:user)
    @user.goals.create(week_id: @this_week.id, category_id: 1, description: "test", total_goal_count: 3)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    allow_any_instance_of(ApplicationController).to receive(:current_week).and_return(@this_week)
  end

  xscenario "clicks plus sign", js: true do

    visit user_goals_path

     find(:css, ".goal-inc").click

     expect(@user.goals.first.progress_count).to eq(1)
  end

end
