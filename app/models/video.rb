class Video < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy

  has_one_attached :uploaded_video

  validates :title, presence: true
  validates :uploaded_video, presence: true
  validate :acceptable_video

  def acceptable_video
    return unless uploaded_video.attached?

    unless uploaded_video.byte_size <= 1.gigabyte
      errors.add(:uploaded_video, "is too big")
    end

    acceptable_types = ["video/mp4", "video/mpeg", "video/quicktime"]
    unless acceptable_types.include?(uploaded_video.content_type)
      errors.add(:uploaded_video, "must be a MP4, MPEG or MOV")
    end
  end
end
