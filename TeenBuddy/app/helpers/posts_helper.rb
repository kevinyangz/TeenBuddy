module PostsHelper
  def get_posts_routes
    posts_routes = []
    @posts.each do |post|
      posts_routes.push(post_url(post))
    end
    posts_routes
  end
end
