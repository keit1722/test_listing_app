class HotSpringsController < ApplicationController
  layout :determine_layout

  def index
    @hot_springs =
      HotSpring
      .with_attached_images
      .page(params[:page])
      .per(20)
      .order(created_at: :desc)
  end

  def show
    @hot_spring = HotSpring.with_attached_images.find_by(slug: params[:slug])
  end
end
