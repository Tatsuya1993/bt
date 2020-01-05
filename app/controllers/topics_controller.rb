class TopicsController < ApplicationController
  
  def index
    @topics = Topic.includes(:favorite_users).paginate(page: params[:page], per_page: 10).search(params[:search])
    @all_ranks = Topic.find(Favorite.group(:topic_id).order('count(topic_id) desc').limit(10).pluck(:topic_id))
    
    if params[:tag_name]
      @topics = @topics.tagged_with("#{params[:tag_name]}")
    end
  end

  def new
    @topic = Topic.new
  end
  
  
  def create
    @topic = current_user.topics.new(topic_params)
    if params[:back]
      render :new
    elsif @topic.save
      redirect_to @topic
      flash[:info] = "記事が投稿されました。"
    else
      render :new
    end
  end
  
  def confirm
    @topic = current_user.topics.new(topic_params)
    render :new if @topic.invalid?
  end
  
  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comments = @topic.comments
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    @topic.update(topic_params)
    flash[:success] = "記事は編集されました"
    redirect_to @topic
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    
    if current_user.id == @topic.user_id
      @topic.destroy
      flash[:success] = "記事は削除されました"
      redirect_to topics_path
    else
      redirect_to @topic
      flash[:danger] = "記事は作成者以外消せません。"
    end
  end
  
  private

  def topic_params
    params.require(:topic).permit(:title, :content, :tag_list)
  end
  
  def correct_user
    @topic = current_user.topic.find_by(id: params[:id])
    redirect_to current_user if @topic.nil?
  end
  
end
