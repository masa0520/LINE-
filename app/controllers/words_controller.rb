class WordsController < ApplicationController
  def index
    @english_words = EnglishWord.all
    @japanese_words = JapaneseWord.all
  end

  def new
    @english_word = EnglishWord.new
    @japanese_word = JapaneseWord.new
  end
  
  def create
    #英語のパラメーターを取得
    input_english = params[:english_word][:english]
    #スペースで区切った英語を配列に格納
    array_english = input_english.split(/[[:space:]]/)

    #日本語のパラメーターを取得
    input_japanese = params[:japanese_word][:japanese]
    #スペースで区切った日本語を配列に格納
    array_japanese = input_japanese.split(/[[:space:]]/)
    
    #英語が一つだったら
    if array_english.second.nil?
      #英語を作成
      @english_word = current_user.english_words.create(english_word_params)
      #eaachで日本語を一つずつ取り出し作成,英語と結びつけて中間テーブルに保存
      array_japanese.each do |word|
        @japanese_word = current_user.japanese_words.create(japanese: word)
        @english_word.japanese_words << @japanese_word
      end
      redirect_to words_path
    #英語が2つ以上だったら
    elsif array_english.second.present? & array_japanese.second.nil?
      #日本語を作成
      @japanese_word = current_user.japanese_words.create(japanese_word_params)
      #eaachで英語を一つずつ取り出し作成,日本語と結びつけて中間テーブルに保存
      array_english.each do |word|
        @english_word = current_user.english_words.create(english: word)
        @japanese_word.english_words << @english_word
      end
      redirect_to words_path
    else
      render :new
    end
  end
  
  private
  
  def english_word_params
    params.require(:english_word).permit(:english)
  end

  def japanese_word_params
    params.require(:japanese_word).permit(:japanese)
  end
end