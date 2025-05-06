class SpendingLimit < ApplicationRecord
  belongs_to :user
  belongs_to :category
  # Validaciones y lógica específica aquí
end