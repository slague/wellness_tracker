require 'rails_helper'

describe "A user logs in to see his/her goals page" do

  scenario "when logging in for the first time, a user must enter name and cohort" do

    Capybara.app = WellnessTracker::Application

    stub_github_oath
    current_week = create :week
    visit root_path
    expect(page).to have_link("Sign in with GitHub")

    click_link('Sign in with GitHub')

    expect(current_path).to eq(edit_user_path(User.last))
    expect(page).to have_field("Name")
    expect(page).to have_field("Cohort")

    fill_in "Name", with: "Admin"
    fill_in "Name", with: "Staff"

    click_on "Update"

    expect(current_path).to eq(user_goals_path)
  end

  scenario "an admin logs in and has access to the admin dashboard page" do
    admin = User.create(github_id: 1, name: "Admin", cohort: "staff", role: 1)
    login(admin)

    visit admin_dashboard_index_path

    save_and_open_page

  end
end
