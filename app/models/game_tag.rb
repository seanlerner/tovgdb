class GameTag < ActiveRecord::Base
  extend GameTagHelper

  # So child classes won't utilize the implied STI table name of this class
  self.abstract_class = true

  # Scopes
  default_scope { order(name: :asc) }

  # Validations
  validates :name, presence: { message: "Please enter the name of this #{name}." }
  validates :name, uniqueness: { message: "There is already a #{name.downcase} with this name." }
end
