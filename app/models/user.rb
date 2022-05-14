# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  first_name       :string           not null
#  last_name        :string           not null
#  role             :integer          default(1), not null
#  salt             :string
#  slug             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_slug   (slug) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password,
            length: {
              minimum: 3,
            },
            if: -> { new_record? || changes[:crypted_password] }
  validates :password,
            confirmation: true,
            if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }

  validates :email,
            uniqueness: true,
            presence: true,
            length: {
              maximum: 255,
            },
            format: {
              with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
            }

  validates :slug,
            uniqueness: true,
            presence: true,
            length: {
              maximum: 50,
            },
            format: {
              with: /\A[\w\-]+\z/,
            }

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
end
