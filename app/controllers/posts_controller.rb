class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    @words = Word.where(post_id: @post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @english_word = EnglishWord.new
    @japanese_word = JapaneseWord.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      #@english_word = current_user.english_words.create(english_word_params.merge(post_id: @post.id))
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
          @english_word = current_user.english_words.create(english: english[0])
          japanese.each do |word|
            @japanese_word = current_user.japanese_words.create(japanese: word)
            @word = Word.create(english_word_id: @english_word.id, japanese_word_id: @japanese_word.id, post_id: @post.id)
          end
        #日本語が１つで英語が2つ以上だったら
        elsif japanese.length == 1 && english.length >= 2
          @japanese_word = current_user.japanese_words.create(japanese: japanese[0])
          english.each do |word|
            @english_word = current_user.english_words.create(english: word)
            @word = Word.create(english_word_id: @english_word.id, japanese_word_id: @japanese_word.id, post_id: @post.id)
          end
        #英語が1つで日本語も１つだったら
        else english.length == 1 && japanese.length == 1
          @english_word = current_user.english_words.create(english: english[0])
          @japanese_word = current_user.japanese_words.create(japanese: japanese[0])
          @word = Word.create(english_word_id: @english_word.id, japanese_word_id: @japanese_word.id, post_id: @post.id)
        end
      end
      redirect_to posts_url, notice: "Post was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :user_id)
    end

    #def english_word_params
    #  params.require(:english_word).permit(:english, :user_id)
    #end 
#
    #def japanese_word_params
    #  params.require(:japanese_word).permit(:japanese, :user_id)
    #end
end
