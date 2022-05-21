class ShopsController < ApplicationController
  layout :determine_layout

  def index
    @shops = Shop.all.order(created_at: :desc)
  end

  def show
    @shop = Shop.with_attached_images.find_by(slug: params[:slug])
  end

  private

  def determine_layout
    action_name == 'index' ? 'listing_index' : 'listing_single'
  end
end
