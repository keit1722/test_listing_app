# == Schema Information
#
# Table name: shops
#
#  id              :bigint           not null, primary key
#  address         :string           not null
#  description     :text             not null
#  lat             :float            not null
#  lng             :float            not null
#  name            :string           not null
#  slug            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint
#
# Indexes
#
#  index_shops_on_name             (name) UNIQUE
#  index_shops_on_organization_id  (organization_id)
#  index_shops_on_slug             (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Shop < ApplicationRecord
  belongs_to :organization

  has_many_attached :images

  has_many :district_mappings, as: :districtable, dependent: :destroy
  has_many :districts, through: :district_mappings

  has_many :shop_category_mappings, dependent: :destroy
  has_many :shop_categories, through: :shop_category_mappings
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  has_many :users, through: :bookmarks

  validates :name, length: { maximum: 100 }, uniqueness: true, presence: true
  validates :address, length: { maximum: 100 }, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :slug,
            length: {
              maximum: 100,
            },
            uniqueness: true,
            presence: true,
            format: {
              with: /\A[a-z0-9\-]+\z/,
            }
  validates :description, length: { maximum: 10_000 }, presence: true
  validates :images,
            attached: true,
            limit: {
              max: 5,
            },
            content_type: %i[png jpg jpeg]
  validates :shop_category_ids, presence: true
  validates :district_ids, presence: true

  def to_param
    slug
  end
end
