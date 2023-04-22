module PostsHelper
  def created(post)
    post.created_at.strftime('%Y/%m/%d')
  end
end
