class HotelsController < ApplicationController
  layout :determine_layout

  def index
    @hotels =
      Hotel
        .with_attached_images
        .page(params[:page])
        .per(20)
        .order(created_at: :desc)
  end

  def show
    @hotel = Hotel.with_attached_images.find_by(slug: params[:slug])
    @posts = @hotel.posts.published.with_attached_image.order(created_at: :desc)
  end
end
