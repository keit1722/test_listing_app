class RestaurantsController < ApplicationController
  layout :determine_layout

  def index
    @restaurants =
      Restaurant
        .with_attached_images
        .includes(:restaurant_categories)
        .all
        .order(created_at: :desc)
  end

  def show
    @restaurant = Restaurant.with_attached_images.find_by(slug: params[:slug])
  end

  private

  def determine_layout
    action_name == 'index' ? 'listing_index' : 'listing_single'
  end
end
