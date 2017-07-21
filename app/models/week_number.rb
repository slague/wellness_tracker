class WeekNumber < ApplicationRecord
  has_many :weeks
  validates :name, presence: true
end
