class Winner < ApplicationRecord
  belongs_to :user
  belongs_to :week

  validates_presence_of :user_id, :week_id
   validates :week_id, uniqueness: true

end
