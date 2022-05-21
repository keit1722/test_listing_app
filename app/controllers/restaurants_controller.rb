class RestaurantsController < ApplicationController
  layout :determine_layout

  def index
    @restaurants =
      Restaurant
        .with_attached_images
        .includes(:restaurant_categories)
        .page(params[:page])
        .per(20)
        .order(created_at: :desc)
  end

  def show
    @restaurant = Restaurant.with_attached_images.find_by(slug: params[:slug])
  end
end
