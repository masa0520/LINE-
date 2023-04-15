class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    @words = Word.where(post_id: @post.id)
    @english_words = EnglishWord.where(post_id: @post.id)
    @japanese_words = JapaneseWord.where(post_id: @post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @english_word = EnglishWord.new
    @japanese_word = JapaneseWord.new
  end

  # GET /posts/1/edit
  def edit
    @words = Word.where(post_id: @post.id)
    @english_words = EnglishWord.where(post_id: @post.id)
    @japanese_words = JapaneseWord.where(post_id: @post.id)
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)
    if @post.title.present?
      10.times do |i|
        input_english = params[:english][i.to_s].split(/[[:space:]]/) if params[:english][i.to_s].present?
        input_japanese = params[:japanese][i.to_s].split(/[[:space:]]/) if params[:japanese][i.to_s].present?
        #英語と日本語がともに存在し、かつ両方の要素が複数でなく、片方が複数である可能性を含む場合に処理を実行
        if input_english.present? && input_japanese.present? && !(input_english.length >= 2 && input_japanese.length >= 2)
         @post.save unless @post.persisted?
         input_english.each do |en|
           english_word = current_user.english_words.find_or_create_by(english: en, post_id: @post.id)
           input_japanese.each do |jp|
             japanese_word = current_user.japanese_words.find_or_create_by(japanese: jp, post_id: @post.id)
             Word.find_or_create_by(english_word_id: english_word.id, japanese_word_id: japanese_word.id, post_id: @post.id)
           end
          end
        end
      end
      if @post.persisted?
        redirect_to @post, notice: t('posts.create.success') if @post.persisted?
      else#この処理は@post.titleは存在するが他がnilの場合
        @post = Post.new
        @english_word = EnglishWord.new
        @japanese_word = JapaneseWord.new
        flash.now[:alert] = t('posts.create.failure')
        render :new, status: :unprocessable_entity
      end
    else
      @post = Post.new
      @english_word = EnglishWord.new
      @japanese_word = JapaneseWord.new
      flash.now[:alert] = t('posts.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    # 既存の単語をすべて削除
    @post.words.destroy_all
    @post.english_words.destroy_all
    @post.japanese_words.destroy_all
    if @post.title.present?
      10.times do |i|
        input_english = params[:english][i.to_s].split(/[[:space:]]/) if params[:english][i.to_s].present?
        input_japanese = params[:japanese][i.to_s].split(/[[:space:]]/) if params[:japanese][i.to_s].present?
        #英語と日本語がともに存在し、かつ両方の要素が複数でなく、片方が複数である可能性を含む場合に処理を実行
        if input_english.present? && input_japanese.present? && !(input_english.length >= 2 && input_japanese.length >= 2)
         @post.update(post_params) unless @post.changed?
         input_english.each do |en|
           english_word = current_user.english_words.find_or_create_by(english: en, post_id: @post.id)
           input_japanese.each do |jp|
             japanese_word = current_user.japanese_words.find_or_create_by(japanese: jp, post_id: @post.id)
             Word.find_or_create_by(english_word_id: english_word.id, japanese_word_id: japanese_word.id, post_id: @post.id)
           end
          end
        end
      end
      if @post.persisted?
        redirect_to @post, notice: t('posts.update.success') if @post.persisted?
      else#この処理は@post.titleは存在するが他がnilの場合
        @post = Post.new
        @english_word = EnglishWord.new
        @japanese_word = JapaneseWord.new
        flash.now[:alert] = t('posts.update.failure')
        render :new, status: :unprocessable_entity
      end
    else
      @post = Post.new
      @english_word = EnglishWord.new
      @japanese_word = JapaneseWord.new
      flash.now[:alert] = t('posts.update.failure')
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: t('posts.destroy.success')
  end

  def my_posts
    @my_posts = Post.where(user_id: current_user.id)
  end

  def bookmarks
    @bookmark_posts = current_user.bookmark_posts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :user_id, :genre_id)
    end

    def english_word_params
      params.require(:english_word).permit(:english, :user_id, :post_id)
    end 

    def japanese_word_params
      params.require(:japanese_word).permit(:japanese, :user_id, :post_id)
    end
end
