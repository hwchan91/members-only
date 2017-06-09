class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @micropost = current_user.posts.build(post_params)
    if @micropost.save
      flash[:success] = "Post created"
      redirect_to posts_url
    else
      flash[:danger] = "Invalid post"
      render 'new'
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

end
