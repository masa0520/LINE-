class BookmarksController < ApplicationController
  before_action :set_post

  def create
    current_user.bookmarks.create(post_id: @post.id)

    render turbo_stream: turbo_stream.replace(
      'bookmark',
      partial: 'bookmarks/bookmark',
      locals: { post: @post },
    )
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(post_id: @post.id)
    bookmark.destroy

    render turbo_stream: turbo_stream.replace(
      'bookmark',
      partial: 'bookmarks/bookmark',
      locals: { post: @post },
    )
  end
  
  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
