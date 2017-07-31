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
    it "responds to start_date, end_date, week_number, goals, users, mod" do
      week = create(:week)
      expect(week).to respond_to(:start_date, :end_date, :week_number, :goals, :users, :mod)
    end
  end

  describe "methods" do
    it ".set_weeks" do
      mod = Mod.create(id: 1, inning: "1701")
      week_1 = WeekNumber.create(id: 1, name: "1 week")
      week_2 = WeekNumber.create(id: 2, name: "2 week")
      week_set = Week.set_weeks(2, Date.today, 1)

    expect(week_set).to be_a(Hash)
    expect(week_set.count).to eq(2)
    expect(week_set[1]).to eq([Date.today, Date.today + 6])
    expect(week_set[2]).to eq([Date.today + 7, Date.today + 13])
    end

    it ".get_start_dates" do
      week_1 = Week.create(start_date: Date.today, end_date: Date.today + 6)
      week_2 = Week.create(start_date: Date.today + 7, end_date: Date.today + 13)

      start_dates = Week.get_start_dates

      expect(start_dates).to be_an(Array)
      expect(start_dates[0]).to eq(Date.today)
      expect(start_dates[1]).to eq(Date.today + 7)
    end

    it ".get_end_dates" do
      week_1 = Week.create(start_date: Date.today, end_date: Date.today + 6)
      week_2 = Week.create(start_date: Date.today + 7, end_date: Date.today + 13)

      end_dates = Week.get_end_dates

      expect(end_dates).to be_an(Array)
      expect(end_dates[0]).to eq(Date.today + 6)
      expect(end_dates[1]).to eq(Date.today + 13)
    end

    it ".order_by_created_at" do
      week_1 = Week.create(start_date: Date.today, end_date: Date.today + 6)
      week_2 = Week.create(start_date: Date.today + 7, end_date: Date.today + 13)

      weeks = Week.order_by_created_at

      expect(weeks.count).to eq(2)
      expect(weeks[0]).to eq(week_1)
      expect(weeks[1]).to eq(week_2)
    end

    it "#format_start_date" do
      week_1 = Week.create(start_date: "2017-07-24", end_date: "2017-07-30")

      expect(week_1.format_start_date).to eq("July 24")
    end

    it "#format_end_date" do
      week_1 = Week.create(start_date: "2017-07-24", end_date: "2017-07-30")

      expect(week_1.format_end_date).to eq("30 2017")
    end

  end
end
