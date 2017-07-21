require 'rails_helper'

RSpec.describe Week, type: :model  do
  describe "validations" do
    context "a week is valid with all attributes" do
      it { is_expected.to validate_presence_of(:start_date)}
      it { is_expected.to validate_presence_of(:end_date)}
    end
  end
  
  context "invalid" do
    it "a week is invalid without a start date" do
      week = Week.new(start_date: Date.today)
      expect(week).to_not be_valid
    end
    it "a week is invalid without an end date" do
      week = Week.new(end_date: Date.today)
      expect(week).to_not be_valid
    end
  end

  describe "attributes" do
    it "responds to start_date, end_date, week_number, goals, users" do
      week = create(:week)
      expect(week).to respond_to(:start_date, :end_date, :week_number, :goals, :users)
    end
  end

  describe "methods" do
    it ".set_weeks" do
    week_set = Week.set_weeks(6, Date.today)

    expect(week_set).to be_a(Hash)
    expect(week_set.count).to eq(6)
    expect(week_set[1]).to eq([Date.today, Date.today + 6])
    expect(week_set[2]).to eq([Date.today + 7, Date.today + 13])
    end
  end
end
