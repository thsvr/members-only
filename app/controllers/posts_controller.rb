class PostsController < ApplicationController
  before_action :logged_in?, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      render 'index'
    end
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end

  
end
