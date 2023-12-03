# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show]

  def index
    @categories = Category.all

    render json: @categories
  end

  def show
    render json: @category
  end

  private

  def set_category
    if params[:catalog_id]
      @catalog = Catalog.find(params[:catalog_id])
      @category = @catalog.category
    else
      @category = Category.find(params[:id])
    end
  end

  def category_params
    params.require(:category).permit(:kind)
  end
end
