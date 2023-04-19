class WordMemoriesController < ApplicationController
  before_action :set_english
  before_action :set_japanese
  before_action :set_word
  before_action :set_post

  def create
    if @en_id.present?
      current_user.word_memories.create(english_word_id: @en_id)
      render turbo_stream: turbo_stream.replace(
        "en_memorized#{@en_id}",
        partial: 'word_memories/en_memory',
        locals: { post: @post, en: @en_id },
      )
    elsif  @jp_id.present?
      current_user.word_memories.create(japanese_word_id: @jp_id)
      render turbo_stream: turbo_stream.replace(
        "jp_memorized#{@jp_id}",
        partial: 'word_memories/jp_memory',
        locals: { post: @post, jp: @jp_id },
      )
    else
      current_user.word_memories.create(word_id: @wo_id)
      render turbo_stream: turbo_stream.replace(
        "memorized#{@wo_id}",
        partial: 'word_memories/wo_memory',
        locals: { post: @post, wo: @wo_id },
      )
    end
  end

  def destroy
    if @en_id.present?
      en_memory = current_user.word_memories.find_by(english_word_id: @en_id)
      en_memory.destroy
      render turbo_stream: turbo_stream.replace(
        "en_memorized#{@en_id}",
        partial: 'word_memories/en_memory',
        locals: { post: @post, en: @en_id },
      )
    elsif @jp_id.present?
      jp_memory = current_user.word_memories.find_by(japanese_word_id: @jp_id)
      jp_memory.destroy
      render turbo_stream: turbo_stream.replace(
        "jp_memorized#{@jp_id}",
        partial: 'word_memories/jp_memory',
        locals: { post: @post, jp: @jp_id },
      )
    else
      word_memory = current_user.word_memories.find_by(word_id: @wo_id)
      word_memory.destroy
      render turbo_stream: turbo_stream.replace(
        "memorized#{@wo_id}",
        partial: 'word_memories/wo_memory',
        locals: { post: @post, wo: @wo_id },
      )
    end
  end

  private

  def set_english
    @en_id = params[:en_id].to_s
  end

  def set_japanese
    @jp_id = params[:jp_id].to_s
  end

  #1対１の場合
  def set_word
    @wo_id = params[:wo_id].to_s
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
