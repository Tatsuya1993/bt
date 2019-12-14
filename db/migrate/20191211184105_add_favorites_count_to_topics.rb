class AddFavoritesCountToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :favorites_count, :integer
  end
end
