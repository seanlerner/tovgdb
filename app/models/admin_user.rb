class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Constants
  ROLES = ['Super Admin', 'Clerk'].freeze

  # Validations
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, unless: 'password.nil?'
  validates :password, presence: true, if: 'id.nil?'
end
