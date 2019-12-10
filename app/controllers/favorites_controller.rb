class FavoritesController < ApplicationController
  def index
    @favorite_topics = current_user.favorite_topics
    @favorite_topics =  @favorite_topics.paginate(page: params[:page])
  end

  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.topic_id = params[:topic_id]
    if favorite.save
      redirect_to favorites_path, success: 'いいね！しました'
    else
      redirect_to favorites_path, danger: 'いいねに失敗しました'
    end
  end
end