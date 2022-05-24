class ActivitiesController < ApplicationController
  layout :determine_layout

  def index
    @activities =
      Activity
        .with_attached_images
        .page(params[:page])
        .per(20)
        .order(created_at: :desc)
  end

  def show
    @activity = Activity.with_attached_images.find_by(slug: params[:slug])
    @posts =
      @activity.posts.published.with_attached_image.order(created_at: :desc)
  end
end
