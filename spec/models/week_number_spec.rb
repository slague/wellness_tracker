require 'rails_helper'

RSpec.describe WeekNumber, type: :model  do
  describe "validations" do
    context "a week_number is valid with all attributes" do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  context "invalid" do
    it "week_number is invalid without a name" do
      week_num = WeekNumber.new()
      expect(week_num).to_not be_valid
    end
  end

  describe "attributes" do
    it "responds to name, created_at, updated_at, weeks" do
      week_num = create(:week_number)
      expect(week_num).to respond_to(:name, :created_at, :updated_at, :weeks)
    end
  end
end
