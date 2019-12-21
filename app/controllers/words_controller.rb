class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def show
    @topic = Word.find(params[:id])
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    render :new if @word.invalid?
  end
  
  def confirm
    @word = Word.new(word_params)
    render :new if @word.invalid?
  end

  def edit
  end

  def destroy
  end
  
  private

  def word_params
    params.require(:word).permit(:name, :description)
  end

end
