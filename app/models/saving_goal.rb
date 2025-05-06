class SavingGoal < ApplicationRecord
  belongs_to :user

  validates :goal_name, presence: true
  validates :target_amount, numericality: { greater_than: 0 }
  validates :saved_amount, numericality: { greater_than_or_equal_to: 0 }
end
