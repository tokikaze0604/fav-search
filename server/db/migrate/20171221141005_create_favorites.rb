class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.decimal :tweet_id, precision: 18, scale: 0
      t.text :text
      t.string :user_name
      t.time :created_at

      t.timestamps
    end
    add_index :favorites, [:tweet_id, :text], unique: true
  end
end
