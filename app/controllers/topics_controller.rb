class TopicsController < ApplicationController
  
  def index
    @topics = Topic.all
    @topics = @topics.paginate(page: params[:page], per_page: 20)
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
  end
  
  private

  def topic_params
      params.require(:topic).permit(:title, :content)
  end
  
end
