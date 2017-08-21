require 'rails_helper'

RSpec.describe Mod, type: :model  do
  describe "validations" do
    context "the mod is valid with all attributes" do
      it { is_expected.to validate_presence_of(:inning)}
    end

    context "invalid" do
      it "is invalid without an inning" do
        mod = Mod.new()

        expect(mod).to_not be_valid
      end
    end
  end

  describe "attributes" do
    it "responds to weeks, users, goals, inning" do
      mod = Mod.create(inning: "1706")

      expect(mod).to respond_to(:weeks, :users, :goals, :inning)
    end
  end

  describe "methods" do
    before do
      Category.create(id: 1, name: "Category")
      WeekNumber.create(id: 1, name: "Week 1")
      WeekNumber.create(id: 2, name: "Week 2")
      WeekNumber.create(id: 3, name: "Week 3")
      WeekNumber.create(id: 4, name: "Week 4")
      WeekNumber.create(id: 5, name: "Week 5")
      WeekNumber.create(id: 6, name: "Week 6")

      @last_mod = Mod.create(inning: "1705")
      @last_mod.weeks.create(id: 1, start_date:"2017-05-01", end_date: "2017-05-08", week_number_id: 1)


      @mod = Mod.create(inning: "1706")

      @mod.weeks.create(id: 2, start_date: "2017-06-26", end_date: "2017-07-02", week_number_id: 1)
      @mod.weeks.create(id: 3, start_date: "2017-07-03", end_date: "2017-07-09", week_number_id: 2)
      @mod.weeks.create(id: 4, start_date: "2017-07-10", end_date: "2017-07-16", week_number_id: 3)
      @mod.weeks.create(id: 5, start_date: "2017-07-17", end_date: "2017-07-23", week_number_id: 4)
      @mod.weeks.create(id: 6, start_date: "2017-07-24", end_date: "2017-07-30", week_number_id: 5)
      @mod.weeks.create(id: 7, start_date: "2017-07-31", end_date: "2017-08-06", week_number_id: 6)


      @user1 = User.create(github_id: 1, name: "A Student", cohort: "1701")
      @user1.goals.create(description: "1111", category_id: 1, week_id: 1, progress_count: 2, total_goal_count: 2)
      @user1.goals.create(description: "2222", category_id: 1, week_id: 2, progress_count: 2, total_goal_count: 2)
      @user1.goals.create(description: "3333", category_id: 1, week_id: 3, progress_count: 2, total_goal_count: 2)
      @user1.goals.create(description: "4444", category_id: 1, week_id: 4, progress_count: 2, total_goal_count: 2)
      @user1.goals.create(description: "5555", category_id: 1, week_id: 5, progress_count: 2, total_goal_count: 2)
      @user1.goals.create(description: "6666", category_id: 1, week_id: 6, progress_count: 2, total_goal_count: 2)
      @user1.goals.create(description: "7777", category_id: 1, week_id: 7, progress_count: 2, total_goal_count: 2)

      @user2 = User.create(github_id: 2, name: "B Student", cohort: "1701")
      @user2.goals.create(description: "1111", category_id: 1, week_id: 1, progress_count: 2, total_goal_count: 2)

      Winner.create(user_id: @user1.id, week_id: 1)
      Winner.create(user_id: @user1.id, week_id: 2)
      Winner.create(user_id: @user1.id, week_id: 3)

    end

    it ".weeks_without_winners" do
      # expect(@last_mod.weeks_without_winners).to eq([])
      expect(Mod.weeks_without_winners).to eq([ Week.find(4), Week.find(5), Week.find(6), Week.find(7) ])
    end

    it "#has_six_weeks" do
      expect(@last_mod.has_six_weeks?).to be false
      expect(@mod.has_six_weeks?).to be true
    end

    it "#fewer_than_six_weeks" do
      expect(@last_mod.fewer_than_six_weeks?).to be true
      expect(@mod.fewer_than_six_weeks?).to be false
    end

    it ".incomplete_mods" do
      expect(Mod.incomplete_mods.first).to eq(@last_mod)
    end

    it "#mod_winners" do
      expect(@mod.mod_winners).to eq(["#{@user1.name}, #{@user1.cohort}"])
      expect(@last_mod.mod_winners).to eq(["#{@user1.name}, #{@user1.cohort}", "#{@user2.name}, #{@user2.cohort}"])
    end
  end
end
