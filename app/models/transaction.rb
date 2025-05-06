class Transaction < ApplicationRecord
  belongs_to :saving_goal, optional: true  # Relación opcional, solo si el tipo es "ahorro"

  validates :transaction_type, inclusion: { in: ['Ingreso', 'Gasto', 'Ahorro'] }
  validates :category_id, presence: true
  belongs_to :user
  belongs_to :month
  belongs_to :category, foreign_key: 'category_id'

  # Validación para asegurarse de que, si el tipo de transacción es "Ahorro", exista una relación con saving_goal
  validate :saving_goal_required_for_savings, if: :is_savings?

  private

  def is_savings?
    transaction_type == 'Ahorro'
  end

  def saving_goal_required_for_savings
    errors.add(:saving_goal, "must be present for savings transactions") unless saving_goal.present?
  end
end