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
        fill_in "weeks[][start_date]", with: "4/2/2017"
        fill_in "weeks[][end_date]", with: "4/8/2017"
        select "1", :from =>"weeks[][week_number_id]"
      end

      within(".week_1") do
        fill_in "weeks[][start_date]", with: "4/9/2017"
        fill_in "weeks[][end_date]", with: "4/15/2017"
        select "2", :from =>"weeks[][week_number_id]"
      end

      within(".week_2") do
        fill_in "weeks[][start_date]", with: "4/16/2017"
        fill_in "weeks[][end_date]", with: "4/22/2017"
        select "3", :from =>"weeks[][week_number_id]"
      end

      within(".week_3") do
        fill_in "weeks[][start_date]", with: "4/23/2017"
        fill_in "weeks[][end_date]", with: "4/29/2017"
        select "4", :from =>"weeks[][week_number_id]"
      end

      within(".week_4") do
        fill_in "weeks[][start_date]", with: "4/30/2017"
        fill_in "weeks[][end_date]", with: "5/6/2017"
        select "5", :from =>"weeks[][week_number_id]"
      end

      within(".week_5") do
        fill_in "weeks[][start_date]", with: "5/7/2017"
        fill_in "weeks[][end_date]", with: "5/13/2017"
        select "6", :from =>"weeks[][week_number_id]"
      end

      click_on "Create Weeks"

      expect(current_path).to eq(admin_weeks_path)

      expect(page).to have_content("Week 1: 2017-02-04 - 2017-08-04")
      # expect(page).to have_content("Week 2: 2017-09-04 - 2017-15-04")
      # expect(page).to have_content("Week 3: 2017-16-04 - 2017-22-04")
      # expect(page).to have_content("Week 4: 2017-23-04 - 2017-29-04")
      # expect(page).to have_content("Week 5: 2017-30-04 - 2017-06-05")
      # expect(page).to have_content("Week 6: 2017-07-05 - 2017-13-05")
      expect(Week.count).to eq(6)
    end
  end
end