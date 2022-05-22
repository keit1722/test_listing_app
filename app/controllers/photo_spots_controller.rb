class PhotoSpotsController < ApplicationController
  layout :determine_layout

  def index
    @photo_spots =
      PhotoSpot
      .with_attached_images
      .page(params[:page])
      .per(20)
      .order(created_at: :desc)
  end

  def show
    @photo_spot = PhotoSpot.with_attached_images.find_by(slug: params[:slug])
  end
end
