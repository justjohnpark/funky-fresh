class PantryParticipation < ActiveRecord::Base
  belongs_to :user
  belongs_to :pantry
end
