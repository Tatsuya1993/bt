class FavoritesController < ApplicationController
  
  def set_up
    @topic = Topic.find(params[:topic_id])
    @id_name = "#favorite-link-#{@topic.id}"
  end

  def index
    @favorite_topics = current_user.favorite_topics
    @favorite_topics =  @favorite_topics.paginate(page: params[:page])
  end
  
  def favorite
    @topic = Topic.find(params[:topic_id])
    favorite = current_user.favorites.new(topic_id: @topic.id)
    favorite.save
    redirect_to @topic
  end
  
  def unfavorite
    @topic = Topic.find(params[:topic_id])
    favorite = current_user.favorites.find_by(topic_id: @topic.id)
    favorite.destroy
    redirect_to @topic
  end

end