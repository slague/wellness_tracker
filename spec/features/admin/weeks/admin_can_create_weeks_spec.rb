require 'rails_helper'

RSpec.feature "Admin can create weeks" do
  context "when providing all information" do
    scenario "they successfully create 6 weeks" do
      week = WeekNumber.create(name: "one")
      week = WeekNumber.create(name: "two")
      week = WeekNumber.create(name: "three")
      week = WeekNumber.create(name: "four")
      week = WeekNumber.create(name: "five")
      week = WeekNumber.create(name: "six")

      visit new_admin_week_path

      within(".week_0") do
        fill_in "weeks[][start_date]", with: "2/4/2017"
        fill_in "weeks[][end_date]", with: "8/4/2017"
        select "1", :from =>"weeks[][week_number_id]"
      end

      within(".week_1") do
        fill_in "weeks[][start_date]", with: "9/4/2017"
        fill_in "weeks[][end_date]", with: "15/4/2017"
        select "2", :from =>"weeks[][week_number_id]"
      end

      within(".week_2") do
        fill_in "weeks[][start_date]", with: "16/4/2017"
        fill_in "weeks[][end_date]", with: "22/4/2017"
        select "3", :from =>"weeks[][week_number_id]"
      end

      within(".week_3") do
        fill_in "weeks[][start_date]", with: "23/4/2017"
        fill_in "weeks[][end_date]", with: "29/4/2017"
        select "4", :from =>"weeks[][week_number_id]"
      end

      within(".week_4") do
        fill_in "weeks[][start_date]", with: "30/4/2017"
        fill_in "weeks[][end_date]", with: "6/5/2017"
        select "5", :from =>"weeks[][week_number_id]"
      end

      within(".week_5") do
        fill_in "weeks[][start_date]", with: "7/5/2017"
        fill_in "weeks[][end_date]", with: "13/5/2017"
        select "6", :from =>"weeks[][week_number_id]"
      end

      click_on "Create Weeks"

      expect(current_path).to eq(admin_weeks_path)

      expect(page).to have_content("Week 1: 2017-04-02 - 2017-04-08")
      expect(page).to have_content("Week 2: 2017-04-09 - 2017-04-15")
      expect(page).to have_content("Week 3: 2017-04-16 - 2017-04-22")
      expect(page).to have_content("Week 4: 2017-04-23 - 2017-04-29")
      expect(page).to have_content("Week 5: 2017-04-30 - 2017-05-06")
      expect(page).to have_content("Week 6: 2017-05-07 - 2017-05-13")
      expect(Week.count).to eq(6)
    end
  end
end