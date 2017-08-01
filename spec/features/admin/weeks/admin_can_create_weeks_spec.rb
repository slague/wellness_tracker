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
    @mod2 = Mod.create(inning: "1703")
    @mod3 = Mod.create(inning: "1705")

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

  scenario "can only set weeks for mods that have fewer than 6 weeks (or no weeks set)" do
    visit admin_dashboard_index_path

    click_on "Set Weeks"

    expect(page).to have_content("Mod")
    expect(page).to have_select("mod_id", options: [@mod2.inning, @mod3.inning])
    expect(page).to_not have_select("mod_id", options: [@mod.inning])
  end

  scenario "can set weeks for mods that have fewer than 6 weeks (or no weeks set)" do
    visit admin_dashboard_index_path

    click_on "Set Weeks"

    select('1703', :from => 'Mod')
    select('6', :from => 'Number of weeks')
    fill_in 'Start date', with: '2017-03-13'
    click_on "Create Weeks"

    expect(current_path).to eq(weeks_path)
    expect(page).to have_content(@mod2.inning)
    expect(page).to have_content(@mod2.weeks.first.start_date.month)
    expect(page).to have_content(@mod2.weeks.first.end_date.month)
    expect(@mod3.weeks.count).to eq(0)
  end

end





















# require 'rails_helper'
#
# RSpec.feature "Admin can create weeks" do
#   context "when providing all information" do
#     xscenario "they successfully create 6 weeks connected to a mod" do
#       mod = Mod.create(inning: "1701")
#       week = WeekNumber.create(name: "one")
#       week = WeekNumber.create(name: "two")
#       week = WeekNumber.create(name: "three")
#       week = WeekNumber.create(name: "four")
#       week = WeekNumber.create(name: "five")
#       week = WeekNumber.create(name: "six")
#
#       visit admin_dashboard_index_path
# save_and_open_page
#       click_on "Set Weeks"
#
#       within(".week_0") do
#         fill_in "weeks[][start_date]", with: "2/4/2017"
#         fill_in "weeks[][end_date]", with: "8/4/2017"
#         select "1", :from =>"weeks[][week_number_id]"
#       end
#
#       within(".week_1") do
#         fill_in "weeks[][start_date]", with: "9/4/2017"
#         fill_in "weeks[][end_date]", with: "15/4/2017"
#         select "2", :from =>"weeks[][week_number_id]"
#       end
#
#       within(".week_2") do
#         fill_in "weeks[][start_date]", with: "16/4/2017"
#         fill_in "weeks[][end_date]", with: "22/4/2017"
#         select "3", :from =>"weeks[][week_number_id]"
#       end
#
#       within(".week_3") do
#         fill_in "weeks[][start_date]", with: "23/4/2017"
#         fill_in "weeks[][end_date]", with: "29/4/2017"
#         select "4", :from =>"weeks[][week_number_id]"
#       end
#
#       within(".week_4") do
#         fill_in "weeks[][start_date]", with: "30/4/2017"
#         fill_in "weeks[][end_date]", with: "6/5/2017"
#         select "5", :from =>"weeks[][week_number_id]"
#       end
#
#       within(".week_5") do
#         fill_in "weeks[][start_date]", with: "7/5/2017"
#         fill_in "weeks[][end_date]", with: "13/5/2017"
#         select "6", :from =>"weeks[][week_number_id]"
#       end
#
#       click_on "Create Weeks"
#
#       expect(current_path).to eq(admin_weeks_path)
#
#       expect(page).to have_content("Week 1: 2017-04-02 - 2017-04-08")
#       expect(page).to have_content("Week 2: 2017-04-09 - 2017-04-15")
#       expect(page).to have_content("Week 3: 2017-04-16 - 2017-04-22")
#       expect(page).to have_content("Week 4: 2017-04-23 - 2017-04-29")
#       expect(page).to have_content("Week 5: 2017-04-30 - 2017-05-06")
#       expect(page).to have_content("Week 6: 2017-05-07 - 2017-05-13")
#       expect(Week.count).to eq(6)
#     end
#   end
# end
