require 'rails_helper'

describe "A user sees goals page after logging in" do

  scenario "when logging in with github" do
    Capybara.app = WellnessTracker::Application
    stub_github_oath
    user = create(:user_with_goals)
    goal = user.goals.first
    week = goal.week

    visit root_path

    expect(page).to have_link("Sign in with Github")

    click_link('Sign in with Github')

    expect(current_path).to eq(user_goals_path(User.last))
    expect(page).to have_link("Logout")
    expect(page).to have_content("Turing Student")
    expect(page).to have_content(week.week_number.name)
    expect(page).to have_content(week.start_date.strftime("%A %B %d %y"))
    expect(page).to have_content(week.end_date.day)
    expect(page).to have_link('New Goal')
    expect(page).to have_link('Logout')


    click_link('Log')
    # expect(page).to have_css("img[src='imagelink']")
  end

  scenario "a logged in user can log out" do
    user = create(:user_with_goals)

    visit user_goals_path(user)

    click_link('Logout')

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Sign in with Github')
    expect(page).to have_content("Welcome to Wellness Tracker")
  end
end
