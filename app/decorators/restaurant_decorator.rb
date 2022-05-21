class RestaurantDecorator < ApplicationDecorator
  delegate_all

  def arranged_categories
    object
      .restaurant_categories
      .map { |restaurant_category| restaurant_category.name }
      .join(' / ')
  end
end
