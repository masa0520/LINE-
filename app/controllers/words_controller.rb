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
    array_english = []
    array_japanese = []
    10.times do |i|
      #英語のパラメーターを取得
      input_english = params[:english][i.to_s]
      #スペースで区切った英語を配列に格納
      array_english << input_english.split(/[[:space:]]/)
      #日本語のパラメーターを取得
      input_japanese = params[:japanese][i.to_s]
      #スペースで区切った日本語を配列に格納
      array_japanese << input_japanese.split(/[[:space:]]/)
    end

    array_english.zip(array_japanese).each do |english, japanese|
      #両方nilだったら
      next if english.empty? && japanese.empty?
      #両方2つ以上の意味を持っていたら
      next if english.length >= 2 && japanese.length >= 2
      #英語がnilで日本語があったら
      next if english.empty? && japanese.present?
      #日本語がnilで英語があったら
      next if japanese.empty? && english.present?
      
      #英語が一つで日本語が2つ以上だったら
      if english.length == 1 && japanese.length >= 2
        english_word = current_user.english_words.create(english: english[0])
        japanese.each do |word|
          japanese_word = current_user.japanese_words.create(japanese: word)
          english_word.japanese_words << japanese_word
        end
      #日本語が１つで英語が2つ以上だったら
      elsif japanese.length == 1 && english.length >= 2
        japanese_word = current_user.japanese_words.create(japanese: japanese[0])
        english.each do |word|
          english_word = current_user.english_words.create(english: word)
          japanese_word.english_words << english_word
        end
      #英語が1つで日本語も１つだったら
      else english.length == 1 && japanese.length == 1
        english_word = current_user.english_words.create(english: english[0])
        japanese_word = current_user.japanese_words.create(japanese: japanese[0])
        english_word.japanese_words << japanese_word
      end
    end
    redirect_to words_path
  end
end