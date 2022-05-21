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
  end

  private

  def determine_layout
    action_name == 'index' ? 'listing_index' : 'listing_single'
  end
end
