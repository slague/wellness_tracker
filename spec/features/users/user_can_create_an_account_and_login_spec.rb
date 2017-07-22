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

    fill_in "Name", with: "Turing Student"
    fill_in "Name", with: "1701"

    click_on "Update User"

    expect(current_path).to eq(user_goals_path)
  end

  scenario "a returning user logs in and sees his/her goals page" do
    user = create :user
    login(user)

    expect(current_path).to eq(user_goals_path)
    expect(page).to have_link("Logout")
    expect(page).to have_link("New Goal")
  end
end
