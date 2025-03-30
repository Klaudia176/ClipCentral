class Setting < ApplicationRecord
belongs_to :user

validates :background, presence: true
validates :font, presence: true

end
