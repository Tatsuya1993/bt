class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    # 昔はnewだとidを渡せなかった。慣習的に関連するモデルを生成するbuild使うと目的が伝わりやすい
    @comment = @topic.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
       render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id]) 
    if @comment.destroy
      render :index
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:user_id, :topic_id, :content)
  end
end
