require 'rails_helper'

RSpec.feature "User can view all set weeks" do
  before do
    WeekNumber.create(id: 1, name: "Week 1")
    WeekNumber.create(id: 2, name: "Week 2")
    WeekNumber.create(id: 3, name: "Week 3")
    WeekNumber.create(id: 4, name: "Week 4")
    WeekNumber.create(id: 5, name: "Week 5")
    WeekNumber.create(id: 6, name: "Week 6")

    @mod = Mod.create(inning: "1701")
    @mod2 = Mod.create(inning: "1703")
    @mod3 = Mod.create(inning: "1705")

    @this_week = @mod.weeks.create(start_date: "2017-06-26", end_date: "2017-07-02", week_number_id: 1)
    @mod.weeks.create(start_date: "2017-07-03", end_date: "2017-07-09", week_number_id: 2)
    @mod.weeks.create(start_date: "2017-07-10", end_date: "2017-07-16", week_number_id: 3)
    @mod.weeks.create(start_date: "2017-07-17", end_date: "2017-07-23", week_number_id: 4)
    @mod.weeks.create(start_date: "2017-07-24", end_date: "2017-07-30", week_number_id: 5)
    @mod.weeks.create(start_date: "2017-07-31", end_date: "2017-08-06", week_number_id: 6)

    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    allow_any_instance_of(ApplicationController).to receive(:current_week).and_return(@this_week)
  end

  scenario "visits calendar link and shows a list of all mods and their set weeks" do
    visit user_goals_path

    expect(page).to have_link("Calendar")

    click_on "Calendar"

    expect(current_path).to eq(weeks_path)
    expect(page).to have_content(@mod.inning)
    expect(page).to have_content(@mod.weeks.first.start_date.month)
    expect(page).to have_content(@mod.weeks.last.start_date.month)
    expect(page).to have_content(@mod2.inning)
    expect(page).to have_content(@mod3.inning)

  end
end
