class Month < ApplicationRecord
  belongs_to :user
  has_many :transactions
  # Otras relaciones y validaciones aquí
end