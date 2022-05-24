class SkiAreasController < ApplicationController
  layout :determine_layout

  def index
    @ski_areas =
      SkiArea
        .with_attached_images
        .page(params[:page])
        .per(20)
        .order(created_at: :desc)
  end

  def show
    @ski_area = SkiArea.with_attached_images.find_by(slug: params[:slug])
    @posts =
      @ski_area.posts.published.with_attached_image.order(created_at: :desc)
  end
end
