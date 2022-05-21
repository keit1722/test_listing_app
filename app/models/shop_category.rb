# == Schema Information
#
# Table name: shop_categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shop_categories_on_name  (name) UNIQUE
#
class ShopCategory < ApplicationRecord
  validates :name, presence: true
end
