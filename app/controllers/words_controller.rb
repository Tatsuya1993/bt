class WordsController < ApplicationController
  def index
    @words = Word.all.paginate(page: params[:page], per_page: 20).search(params[:search])
  end

  def show
    @word = Word.find(params[:id])
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    
    if params[:back]
      render :new
    elsif @word.save
      redirect_to @word
      flash[:info] = "単語が登録されました。"
    else
      render :new
    end
  end
  
  def confirm
    @word = Word.new(word_params)
    render :new if @word.invalid?
  end

  def edit
    @word = Word.find(params[:id])
  end
  
  def update
    @word = Word.find(params[:id])
    @word.update(word_params)
    flash[:success] = "単語は編集されました"
    redirect_to @word
  end
  
  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash[:success] = "辞書から削除されました"
    redirect_to words_path
  end
  
  private

  def word_params
    params.require(:word).permit(:name, :description)
  end

end
