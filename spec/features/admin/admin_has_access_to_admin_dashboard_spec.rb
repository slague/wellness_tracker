require 'rails_helper'

RSpec.feature "When a logged in admin visits dashboard" do

  before do
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

    @admin = create(:user)
    @admin.update(role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    allow_any_instance_of(ApplicationController).to receive(:current_week).and_return(@this_week)
  end

  scenario "a logged in admin has access to the admin dashboard" do
    visit admin_dashboard_index_path

    expect(current_path).to eq(admin_dashboard_index_path)
 end

 scenario "a logged in admin sees admin dashboard links" do
   visit admin_dashboard_index_path
   
    expect(page).to have_content(@mod.inning)
    expect(page).to have_content(@this_week.start_date)
    expect(page).to have_content(@this_week.week_number.name)
    expect(page).to have_content("Current Mod")
    expect(page).to have_content("Set Weeks")
    expect(page).to have_content("Weekly Winners")
    expect(page).to have_content("Mod Winners")
  end

end
