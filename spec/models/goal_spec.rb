require 'rails_helper'

RSpec.describe Goal, type: :model  do
  describe "validations" do
    context "the goal is valid with all attributes" do
      it { is_expected.to validate_presence_of(:user_id)}
      it { is_expected.to validate_presence_of(:description)}
      it { is_expected.to validate_presence_of(:total_goal_count)}
      it { is_expected.to validate_presence_of(:week_id)}
    end
  end

  context "invalid" do
    it "is invalid without description" do
      goal = Goal.new(user_id: 1, total_goal_count: 1, category_id: 1, week_id: 1)

      expect(goal).to_not be_valid
    end
    it "is invalid without total_goal_count" do
      goal = Goal.new(user_id: 1, description: "words", category_id: 1, week_id: 1)

      expect(goal).to_not be_valid
    end
    it "is invalid without category_id" do
      goal = Goal.new(user_id: 1, total_goal_count: 1, description: "words", week_id: 1)

      expect(goal).to_not be_valid
    end
    it "is invalid without user_id" do
      goal = Goal.new(description: "words", total_goal_count: 1, category_id: 1, week_id: 1)

      expect(goal).to_not be_valid
    end
    it "is invalid without week_id" do
      goal = Goal.new(user_id: 1, total_goal_count: 1, category_id: 1, description: "words")

      expect(goal).to_not be_valid
    end
  end

  describe "attributes" do
    it "has default 0 progress_count" do
      goal = create(:goal)
      expect(goal.progress_count).to eq(0)
    end

    it "responds to description, total_goal_count, category_id, week_id, user" do
      goal = create(:goal)
      expect(goal).to respond_to(:description, :user_id, :category_id, :total_goal_count, :progress_count, :week_id)
    end
  end

  describe "methods" do
    it ".community_progress" do
      week = create(:week)
      goal = create(:goal)
      goal.update_attributes(week_id: week.id, category_id: 1, user_id: 1, progress_count: 1)
      goal2 = create(:goal)
      goal2.update(week_id: week.id, category_id: 1, user_id: 2, progress_count: 2)
      goal3 = create(:goal)
      goal3.update(week_id: week.id, category_id: 1, user_id: 3, progress_count: 1)

# require "pry"; binding.pry
      comm_prog = Goal.community_progress(1, 1)

      expect(comm_prog).to eq(4)
    end
  end
end
