require 'rails_helper'

RSpec.describe Category, type: :model  do
  describe "validations" do
    context "a category is valid with all attributes" do
      it { is_expected.to validate_presence_of(:name)}
    end
  end

  context "invalid" do
    it "category is invalid without a name" do
      cat = Category.new()
      expect(cat).to_not be_valid
    end
  end

  describe "attributes" do
    it "responds to name, created_at, updated_at, goals" do
      cat = create(:category)
      expect(cat).to respond_to(:name, :created_at, :updated_at, :goals)
    end
  end
end
