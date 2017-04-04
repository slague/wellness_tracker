class Goal < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :week
end
