class PostsController < ApplicationController
  def index
    @posts =
      @postable
        .posts
        .with_attached_image
        .published
        .page(params[:page])
        .per(5)
        .order(created_at: :desc)
  end

  def show
    @post = @postable.posts.published.find(params[:id])
    @posts =
      @postable.posts.with_attached_image.published.order(created_at: :desc)
  end
end
