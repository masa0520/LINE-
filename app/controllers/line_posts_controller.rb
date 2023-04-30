class LinePostsController < ApplicationController
  before_action :set_post

  def create
    current_user.line_posts.create(post_id: @post.id)
    redirect_to set_time_post_path(@post)
  end

  def destroy
    line_post = current_user.line_posts.find_by(post_id: @post.id)
    if line_post.destroy
      #LINE連携を切るとpostに設定していた定期実行の時間もnilになる
      @post.update(set_time: nil)
    end
    #redirect_to @post
    render turbo_stream: turbo_stream.replace(
      'line_post',
      partial: 'line_posts/line_post',
      locals: { post: @post },
    )
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
