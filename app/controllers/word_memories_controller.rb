class WordMemoriesController < ApplicationController
  before_action :set_word
  before_action :set_meaning
  before_action :set_word_meaning
  before_action :set_post

  def create
    if @word_id.present?
      current_user.word_memories.create(word_id: @word_id)
      render turbo_stream: turbo_stream.replace(
        "word_memorized#{@word_id}",
        partial: 'word_memories/word_memory',
        locals: { post: @post, word: @word_id },
      )
    elsif @meaning_id.present?
      current_user.word_memories.create(meaning_id: @meaning_id)
      render turbo_stream: turbo_stream.replace(
        "meaning_memorized#{@meaning_id}",
        partial: 'word_memories/meaning_memory',
        locals: { post: @post, meaning: @meaning_id },
      )
    else
      current_user.word_memories.create(word_meaning_id: @word_meaning_id)
      render turbo_stream: turbo_stream.replace(
        "word_meaning_memorized#{@word_meaning_id}",
        partial: 'word_memories/word_meaning_memory',
        locals: { post: @post, word_meaning: @word_meaning_id },
      )
    end
  end

  def destroy
    if @word_id.present?
      word_memory = current_user.word_memories.find_by(word_id: @word_id)
      word_memory.destroy
      render turbo_stream: turbo_stream.replace(
        "word_memorized#{@word_id}",
        partial: 'word_memories/word_memory',
        locals: { post: @post, word: @word_id },
      )
    elsif @meaning_id.present?
      meaning_memory = current_user.word_memories.find_by(meaning_id: @meaning_id)
      meaning_memory.destroy
      render turbo_stream: turbo_stream.replace(
        "meaning_memorized#{@meaning_id}",
        partial: 'word_memories/meaning_memory',
        locals: { post: @post, meaning: @meaning_id },
      )
    else
      word_meaning_memory = current_user.word_memories.find_by(word_meaning_id: @word_meaning_id)
      word_meaning_memory.destroy
      render turbo_stream: turbo_stream.replace(
        "word_meaning_memorized#{@word_meaning_id}",
        partial: 'word_memories/word_meaning_memory',
        locals: { post: @post, word_meaning: @word_meaning_id },
      )
    end
  end

  private

  def set_word
    @word_id = params[:word_id].to_s
  end

  def set_meaning
    @meaning_id = params[:meaning_id].to_s
  end

  #1対１の場合
  def set_word_meaning
    @word_meaning_id = params[:word_meaning_id].to_s
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
