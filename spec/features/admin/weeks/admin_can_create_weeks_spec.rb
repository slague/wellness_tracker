require 'rails_helper'

RSpec.feature "Admin can create weeks" do
  context "when providing all information" do
    scenario "they successfully create 6 weeks" do
      week = WeekNumber.create(name: "one")
      visit new_admin_week_path

      fill_in "week[start_date]", with: "4/2/2017"
      fill_in "week[end_date]", with: "4/8/2017"
      select "1", :from =>"week[week_number_id]"

      click_on "Create Week"

      expect(current_path).to eq(admin_weeks_path)
      expect(page).to have_content("Week 1: 2017-02-04 - 2017-08-04")
    end
  end
end