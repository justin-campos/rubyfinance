class TransactionsController < ApplicationController
  # Aquí podrías tener acciones como index, create, show, etc.
  before_action :authorize_request
  before_action :set_transaction, only: [:show, :update, :destroy]

  # GET /transactions
  def index
    @transactions = @current_user.transactions
    render json: @transactions
  end

  # GET /transactions/:id
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = @current_user.transactions.new(transaction_params)

    if @transaction.transaction_type == "Ahorro"
      # Buscar la meta de ahorro asociada
      saving_goal = SavingGoal.find(@transaction.saving_goal_id)

      # Actualizar el campo saved_amount de la meta
      saving_goal.saved_amount += @transaction.amount

      # Guardar la meta de ahorro con el nuevo monto
      saving_goal.save
    end

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: { error: @transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/:id
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: { error: 'Error al actualizar la transacción' }, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/:id
  def destroy
    @transaction.destroy
    head :no_content
  end

  def total_ingresos
    # Obtener el mes del parámetro de la solicitud
    mes = params[:mes]
    # Filtrar transacciones para el usuario con el tipo "Ingreso" y el mes especificado
    total = @current_user.transactions
                         .where(transaction_type: 'Ingreso', month_id: mes)
                         .sum(:amount)
    render json: { total_ingresos: total }
  end

  def total_gastos
    # Obtener el mes del parámetro de la solicitud
    mes = params[:mes]
    # Filtrar transacciones para el usuario con el tipo "Ingreso" y el mes especificado
    total = @current_user.transactions
                         .where(transaction_type: 'Gasto', month_id: mes)
                         .sum(:amount)
    render json: { total_gastos: total }
  end

  # Método para obtener los datos para el gráfico de pastel
  def pie_chart_data
    # Obtén el mes (month_id) desde los parámetros
    month_id = params[:month_id]

    # Obtener las transacciones del usuario autenticado para ese mes, excluyendo "Ingreso"
    @transactions = @current_user.transactions
                                 .joins(:category)
                                 .where(month_id: month_id)
                                 .where.not('categories.category_mother': 'Ingreso') # Excluir 'Ingreso'

    # Agrupar las transacciones por 'category_mother' y contar cuántas transacciones hay por cada categoría
    @category_counts = @transactions
                         .group('categories.category_mother')
                         .count

    # Calcular los porcentajes
    total_transactions = @category_counts.values.sum.to_f
    @category_percentages = @category_counts.transform_values do |count|
      (count / total_transactions * 100).round(2)
    end

    # Enviar los datos para el gráfico de pastel
    render json: {
      categories: @category_counts.keys,
      values: @category_counts.values,
      percentages: @category_percentages
    }
  end
  def transactions_por_usuario
    mes = params[:mes]  # Obtener el mes pasado como parámetro
    transacciones = @current_user.transactions.where(month_id: mes)

    if transacciones.any?
      render json: transacciones, status: :ok
    else
      render json: { error: 'No se encontraron transacciones para este mes' }, status: :not_found
    end
  end

  def user_transactions_by_month
    # Obtén el mes y el usuario (se pasan como parámetros)
    user_id = params[:user_id] # ID del usuario
    month_id = params[:month_id] # ID del mes (month_id)

    # Obtén las transacciones para el usuario específico en el mes dado
    @transactions = Transaction.joins(:category)
                               .where(user_id: user_id)
                               .where(month_id: month_id)

    # Agrupar las transacciones por 'category_mother' y contar
    @category_counts = @transactions
                         .group('categories.category_mother')
                         .count

    # Calcular los porcentajes
    total_transactions = @category_counts.values.sum.to_f
    @category_percentages = @category_counts.transform_values do |count|
      (count / total_transactions * 100).round(2)
    end

    render json: { category_counts: @category_counts, category_percentages: @category_percentages }
  end


    private

  # Establece la transacción a partir del ID en los parámetros
  def set_transaction
    @transaction = @current_user.transactions.find_by(id: params[:id])
    render json: { error: 'Transacción no encontrada' }, status: :not_found unless @transaction
  end

  # Permite solo los parámetros permitidos para una transacción
  def transaction_params
    params.require(:transaction).permit(:amount, :description, :transaction_type, :date, :category_id, :month_id, :debit_or_credit, :saving_goal_id)
  end
end
