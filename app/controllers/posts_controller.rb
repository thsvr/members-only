# frozen_string_literal: true

class PostsController < ApplicationController
  include SessionsHelper
  before_action :logged_in?, only: %i[new create]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)            
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy; end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
