class Favorite < ApplicationRecord
  include FavoriteSearchable
  validates :tweet_id, :uniqueness => {:scope => :text}
end
