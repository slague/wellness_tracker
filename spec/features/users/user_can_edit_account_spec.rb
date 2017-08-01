require 'rails_helper'

describe "When a user is logged in" do
  before do
    @user = create :user
    login(@user)
  end

  it "can edit profile information" do

    visit edit_user_path(@user)
    expect(page).to have_content("Update your account information")

    fill_in "Name", with: "New Name"
    fill_in "Cohort", with: "1234"

    click_on "Update"

    expect(current_path).to eq(user_goals_path)
    expect(page).to have_content("New Name")

  end

  xit "can opt in for text messages" do
    visit edit_user_path(@user)

    check('Yes, I would like to receive reminder texts.')
    fill_in "Phone number", with: "414-517-9678"
    click_on "Update"

    expect(current_path).to eq(user_goals_path)
    expect(@user.wants_reminder?).to eq(true)
  end

  xit "can opt out of text messages" do
    @user.update(wants_reminder: 1)
    visit edit_user_path(@user)

    uncheck('Yes, I would like to receive reminder texts.')

    click_on "Update"
    expect(current_path).to eq(user_goals_path)
    expect(@user.wants_reminder?).to eq(false)
  end

end
