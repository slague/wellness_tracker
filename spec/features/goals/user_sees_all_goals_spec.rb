require "rails_helper"

describe "User sees all goals" do
  scenario "a user sees all his/her goals for the current_week" do
    # week = create :week
    category = create :category
    user = create :user

    login(user)

    visit user_goals_path

    click_on "New Goal"

    fill_in "Description", with: "Run 3 miles"
    fill_in "Total goal count", with: 3
    select category.name, :from=>'goal[category_id]'

    click_on "Create Goal"

    click_on "New Goal"

    fill_in "Description", with: "Drink plenty of water"
    fill_in "Total goal count", with: 7
    select category.name, :from=>'goal[category_id]'

    click_on "Create Goal"

    expect(current_path).to eq(user_goals_path)
    # expect(user.goals.count).to eq(2)
    expect(page).to have_content ("Run 3 miles")
    expect(page).to have_content ("Drink plenty of water")
  end
end
