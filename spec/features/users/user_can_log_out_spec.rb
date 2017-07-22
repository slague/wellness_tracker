require 'rails_helper'

describe "When a user is logged in" do
  it "can log out" do
    user = create :user
    login(user)

    expect(current_path).to eq(user_goals_path)
    expect(page).to have_link("Logout")

    click_on "Logout"

    expect(current_path).to eq(root_path)
  end
end
