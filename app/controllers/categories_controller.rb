class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    render json: @categories
  end

  # GET /categories/:id
  def show
    render json: @category
  end


  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: { error: 'Failed to create category' }, status: :unprocessable_entity
    end
  end

  private

  # Permite solo los parámetros permitidos para una categoría
  def category_params
    params.require(:category).permit(:category_name, :has_limit, :category_mother)
  end
end
