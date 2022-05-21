class ShopsController < ApplicationController
  def index
    @shops = Shop.all.order(created_at: :desc)
  end

  def show
    @shop = Shop.with_attached_images.find_by(slug: params[:slug])
  end
end
