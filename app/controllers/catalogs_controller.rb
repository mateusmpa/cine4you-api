# frozen_string_literal: true

class CatalogsController < ApplicationController
  before_action :set_catalog, only: %i[show]
  before_action :set_catalogs, only: %i[index suggestions]

  def index
    results = @catalogs.page(params[:page]).per(params[:per])

    render json: {
      total_count: results.total_count,
      per_page: results.limit_value,
      page: results.current_page,
      results:
    }
  end

  def show
    render json: @catalog.as_json(include_cast: true)
  end

  def suggestions
    @suggested_catalogs = CatalogSuggestionsService.new(@catalogs).execute

    render json: @suggested_catalogs
  end

  private

  def set_catalog
    @catalog = Catalog.find(params[:id])
  end

  def set_catalogs
    @catalogs = if_like || if_genre_id || if_category_id || default_catalogs
  end

  def if_like
    Catalog.where('title LIKE ?', "%#{params[:like]}%") if params[:like].present?
  end

  def if_genre_id
    Genre.find(params[:genre_id]).catalogs if params[:genre_id].present?
  end

  def if_category_id
    Category.find(params[:category_id]).catalogs if params[:category_id].present?
  end

  def default_catalogs
    Catalog.all
  end

  def catalog_params
    params.require(:catalog).permit(:title, :category_id, :genre_id)
  end
end
