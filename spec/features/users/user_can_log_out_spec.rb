require 'rails_helper'

describe "When a user is logged in" do
  it "dude can log out" do
    user = User.create(census_uid: 420, census_access_token:ENV["census_access_token"]) #change to census info
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)


    visit user_goals_path(user)

    click_on "Log out"
    expect(page).to have_content "Successfully logged out."
    expect(page).to have_content "Log in"

  end
end
