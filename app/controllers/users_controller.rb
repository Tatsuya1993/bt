class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    # gem_will_pagenateにはpagenateメソッドで呼び出す必要がある
    # @users = User.where(activated: true).paginate(page: params[:page]).search(params[:search])
    @users = if params[:search]
      #searchされた場合は、原文+.where('name LIKE ?', "%#{params[:search]}%")を実行
      User.where(activated: true).paginate(page: params[:page]).where('name LIKE ? OR affiliation LIKE ? OR s_introduction LIKE ? ', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      #searchされていない場合は、原文そのまま
      User.where(activated: true).paginate(page: params[:page])
    end
  end
  
  def show
    @user = User.find(params[:id])
    @topics = @user.topics.paginate(page: params[:page])
    @topics_all = Topic.all
    @favorite_count = {}
    @topics_all.each do |topic|
      @favorite_count.store("#{topic.user_id}", Favorite.where(topic_id: topic.id).count)
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "アカウントを有効化するために、あなたにお送りしたメールを確認してください。"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "《管理者専用》選択したユーザーは削除されました。"
    redirect_to users_url
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :s_introduction, :affiliation)
    end
    
    # beforeアクション
    # ログイン済みユーザーかどうか確認
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "まずはログインをお願いします。"
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
