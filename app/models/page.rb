class Page < ApplicationRecord
  # Validations
  validates :title, presence: { message: 'Please enter the title of this page.' }
  validates :slug, presence: { message: 'Please enter the slug of this page.' }
  validates :slug, uniqueness: { message: 'There is already a page with this slug.' }
end
