# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'time'

ActiveRecord::Base.transaction do
  file_path = 'public/favorites.txt'
  json_data = open(file_path) do |io|
    JSON.load(io)
  end

  json_data.each do |j|
    Favorite.create(
      tweet_id: j[1]['tweet_id'],
      text: j[1]['text'],
      user_name: j[1]['user_name'],
      created_at: Time.parse(j[1]['created_at'])
    )
  end
end
