# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string
#  email            :string           not null
#  first_name       :string           not null
#  last_name        :string           not null
#  public_uid       :string
#  role             :integer          default("general"), not null
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email       (email) UNIQUE
#  index_users_on_public_uid  (public_uid) UNIQUE
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

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  enum role: { general: 1, business: 2, admin: 9 }
end
