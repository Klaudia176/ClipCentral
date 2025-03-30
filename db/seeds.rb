# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#User.create!(email: "user@example.com", password: '123123', password_confirmation: '123123', role: :standard, name: "Standard User")
#User.create!(email: "premium@example.com", password: '123123', password_confirmation: '123123', role: :premium, name: "Premium User")
#User.create!(email: "admin@example.com", password: '123123', password_confirmation: '123123', role: :admin, name: "Admin User")

# Hasło dla użytkowników: Hasło123@

Setting.find_or_create_by(background: "linear-gradient(114.2deg, rgb(121, 194, 243) 22.6%, rgb(255, 180, 239) 67.7%)", font: "Montserrat, sans-serif")