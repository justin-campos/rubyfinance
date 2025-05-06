class SavingGoalsController < ApplicationController
  before_action :authorize_request
  before_action :set_user

  # POST /saving_goals
  def create
    @saving_goal = @user.saving_goals.new(saving_goal_params)
    if @saving_goal.save
      render json: @saving_goal, status: :created
    else
      render json: @saving_goal.errors, status: :unprocessable_entity
    end
  end

  # GET /saving_goals
  def index
    # Recupera todas las metas de ahorro asociadas al usuario autenticado.
    @saving_goals = @current_user.saving_goals

    render json: @saving_goals
  end

  # GET /saving_goals/:id/percentage_left
  def percentage_left
    saving_goal = @current_user.saving_goals.limit(1).first

    if saving_goal
      target_amount = saving_goal.target_amount
      saved_amount = saving_goal.saved_amount
      goal_name = saving_goal.goal_name

      # Calcular el porcentaje
      faltante = target_amount - saved_amount
      percentage_left_calculated = ((faltante / target_amount) * 100).round(2)
      percentage_left = saved_amount >= target_amount ? 100 : percentage_left_calculated
      percentage_right = 100 - percentage_left

      render json: {
        goal_name: goal_name,
        target_amount: target_amount,
        saved_amount: saved_amount,
        percentage_left: percentage_left,
        percentage_right: percentage_right,
        percentage_left_calculated: percentage_left_calculated,
        amount_left: faltante
      }
    else
      render json: { error: 'No saving goal found' }, status: :not_found
    end

  end

  private

  def set_user
    @user = @current_user
  end

  def saving_goal_params
    params.require(:saving_goal).permit(:goal_name, :target_amount, :saved_amount, :deadline)
  end
end

