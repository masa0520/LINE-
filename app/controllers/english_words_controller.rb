class EnglishWordsController < ApplicationController

  def index
    @english_words = EnglishWord.all
    @japanese_words = JapaneseWord.all
  end

  def new
    @english_word = EnglishWord.new
    @japanese_words = JapaneseWord.new
  end
  
  def create
    #英語を作成
    @english_word = current_user.english_words.create(english_word_params)

    #日本語のパラメーターを取得
    input_text = params[:japanese_word][:japanese]
    #スペースで区切った値を配列に格納
    input_array = input_text.split(/[[:space:]]/)

    #eaachで日本語を一つずつ取り出し作成,英語と結びつけて中間テーブルに保存
    input_array.each do |word|
      @japanese_word = current_user.japanese_words.create(japanese: word)
      @english_word.japanese_words << @japanese_word
    end

    redirect_to english_words_path
  end
  
  private
  
  def english_word_params
    params.require(:english_word).permit(:english)
  end

  def japanese_word_params
    params.require(:japanese_word).permit(:japanese)
  end
end
