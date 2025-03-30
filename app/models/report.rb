class Report < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :reason, presence: true
end
