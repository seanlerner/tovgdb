class MenuItem < ApplicationRecord
  # Constants
  MENUS = ['Main Nav', 'Footer Nav'].freeze

  # Validations
  validates :menu, presence: { message: 'Please select a the menu for this menu item.' }
  validates :menu, inclusion: { in: MENUS }
  validates :name, presence: { message: 'Please enter the name of this menu item.' }
  validates :uri, presence: { message: 'Please enter the uri of this menu item.' }
  validates :order, numericality: { only_integer: true, allow_nil: true }
end
