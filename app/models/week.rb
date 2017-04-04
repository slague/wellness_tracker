class Week < ApplicationRecord
  belongs_to :week_number
  has_many :goals
  has_many :users, through: :goals
end
