# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  Favorite.delete_all
  10.times do |idx|
    Favorite.create!(
        tweet_id: "#{idx}",
        text: "本文 #{idx}",
        user_name: "user_name #{idx}",
        created_at: Date.today.to_time
    )
  end
end
