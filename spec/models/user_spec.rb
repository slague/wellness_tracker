require 'rails_helper'

RSpec.describe User, type: :model  do
  describe "validations" do
    context "a user is valid with all attributes" do
      it { is_expected.to validate_presence_of(:github_id)}
      it { is_expected.to validate_presence_of(:name)}
      it { is_expected.to validate_presence_of(:cohort)}
    end
  end

  context "invalid" do
    it "user is invalid without a github_id" do
      user = User.new(name: "Turing Student", cohort: "1701")

      expect(user).to_not be_valid
    end

    it "user is invalid without a name" do
      user = User.new(cohort: "1701", github_id: 2)

      expect(user).to_not be_valid
    end

    it "is invalid without a cohort" do
      user = User.new(name: "Turing Student", github_id: 2)

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
end
