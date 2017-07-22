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
      cat = create(:category)
      user = create(:user)
      user2 = create(:user)
      user3 = create(:user)

      user.goals.create(description: "a goal", category_id: cat.id, week_id: week.id, progress_count: 2, total_goal_count: 5)
      user2.goals.create(description: "a goal", category_id: cat.id, week_id: week.id, progress_count: 1, total_goal_count: 3)
      user3.goals.create(description: "a goal",category_id: cat.id, week_id: week.id, progress_count: 1, total_goal_count: 4)

      comm_prog = Goal.community_progress(week.id, cat.id)

      expect(comm_prog).to eq(4)
    end

    it ".community_progress" do
      week = create(:week)
      cat = create(:category)
      user = create(:user)
      user2 = create(:user)
      user3 = create(:user)

      user.goals.create(description: "a goal", category_id: cat.id, week_id: week.id, progress_count: 2, total_goal_count: 5)
      user2.goals.create(description: "a goal", category_id: cat.id, week_id: week.id, progress_count: 1, total_goal_count: 3)
      user3.goals.create(description: "a goal",category_id: cat.id, week_id: week.id, progress_count: 1, total_goal_count: 4)

      comm_total = Goal.community_total(week.id, cat.id)
      
      expect(comm_total).to eq(12)
    end
  end
end
