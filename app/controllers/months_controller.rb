class MonthsController < ApplicationController
  def show
    @month = Month.find(params[:id])  # Busca el mes por ID
    render json: @month  # Devuelve el mes en formato JSON
  end

  def index
    @months = Month.all  # Obtiene todos los meses
    render json: @months  # Devuelve todos los meses en formato JSON
  end
end