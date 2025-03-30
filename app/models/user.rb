class User < ApplicationRecord
  # Moduły Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Asocjacje
  has_many :videos
  has_many :comments
  has_many :reports
  has_one_attached :avatar

  # Enum dla ról użytkowników
  enum role: { standard: 0, premium: 1, admin: 2 }

  # Walidacje
  validate :password_complexity
  validates :name, presence: { message: :blank }
  validates :name, uniqueness: { message: :taken }

  private

  def password_complexity
    return if password.blank?

    unless password.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[[:^alnum:]])[[:print:]]+\z/)
      errors.add :password, :must_contain
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["avatar", "created_at", "email", "id", "id_value", "name", "premium", "remember_created_at", "role", "updated_at"]
  end
  
end
