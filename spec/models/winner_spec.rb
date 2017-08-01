require 'rails_helper'

RSpec.describe Winner, type: :model  do
  before do
    WeekNumber.create(id: 1, name: "Week 1")
    WeekNumber.create(id: 2, name: "Week 2")
    User.create(id: 1, github_id: 1, name: "Student")
    Week.create(id: 1, start_date: "2017-06-26", end_date: "2017-07-02", week_number_id: 1)
    Week.create(id: 2, start_date: "2017-07-03", end_date: "2017-07-09", week_number_id: 2)
  end

  describe "validations" do
    context "a winner is valid with all attributes" do
      it { is_expected.to validate_presence_of(:user_id)}
      it { is_expected.to validate_presence_of(:week_id)}
    end

    context "invalid" do
      it "is invalid without a week_id" do
        winner = Winner.new(user_id: 1)

        expect(winner).to_not be_valid
      end
      it "is invalid without a user_id" do
        winner = Winner.new(week_id: 1)

        expect(winner).to_not be_valid
      end

      it "a week has only one winner" do
        winner = Winner.create(user_id: 1, week_id: 1)
        winner2 = Winner.new(user_id: 2, week_id: 1)

        expect(winner2).to_not be_valid
      end
      it "a user can win different weeks" do
        winner = Winner.create(user_id: 1, week_id: 1)
        winner2 = Winner.new(user_id: 1, week_id: 2)

        expect(winner2).to be_valid
      end
    end
  end

  describe "attributes" do
    it "responds to week and user" do
      winner = Winner.create(user_id: 1, week_id: 1)

      expect(winner).to respond_to(:week, :user)
    end
  end
end
