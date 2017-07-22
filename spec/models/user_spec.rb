require 'rails_helper'

RSpec.describe User, type: :model  do
  describe "validations" do
    context "a user is valid with all attributes" do
      it { is_expected.to validate_presence_of(:github_id)}
    end
  end

  context "invalid" do
    it "user is invalid without a github_id" do
      user = User.new(name: "Turing Student", cohort: "1701")

      expect(user).to_not be_valid
    end
  end

  describe "attributes" do
    it "has default role of 0" do
      user = create(:user)

      expect(user.role).to eq("default")
    end

    it "responds to name, github_id, cohort, role, goals" do
      user = create(:user)

      expect(user).to respond_to(:name, :github_id, :cohort, :role, :goals)
    end
  end

  describe ".text_recipients" do
    let!(:text_recipient) { create(:text_recipient_user) }
    let!(:user) { create(:user) }

    it "returns all text_recipients" do
      text_recipients = described_class.text_recipients
      expect(text_recipients).to include(text_recipient)
      expect(text_recipients).to_not include(user)
    end
  end
end
