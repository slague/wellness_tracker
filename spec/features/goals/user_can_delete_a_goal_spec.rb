require 'rails_helper'

describe "User deletes existing goal" do
  scenario "a user can delete a goal" do
    category = create :category
  	user = create :user

    login(user)
    visit user_goals_path

    click_on "New Goal"

    fill_in "Description", with: "Run 3 miles"
    fill_in "Total goal count", with: 3
    select category.name, :from=>'goal[category_id]'

    click_on "Create Goal"

    expect(current_path).to eq(user_goals_path)
    expect(page).to have_link "Delete"

    click_link "Delete"

    expect(page).to_not have_content("Are you sure?")

    expect(page).to_not have_content("Run 3 miles")
  end
end
