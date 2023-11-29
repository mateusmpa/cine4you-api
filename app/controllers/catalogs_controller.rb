class CatalogsController < ApplicationController
  before_action :set_catalog, only: %i[ show ]
  before_action :set_catalogs, only: %i[ index suggestions ]

  def index
    results = @catalogs.page(params[:page]).per(params[:per])

    render json: {
      total_count: results.total_count,
      per_page: results.limit_value,
      page: results.current_page,
      results: results
    }
  end

  def show
    render json: @catalog
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
      if params[:like]
        @catalogs = Catalog.where('title LIKE ?', "%#{params[:like]}%")
      elsif params[:genre_id]
        @catalogs = Genre.find(params[:genre_id]).catalogs
      elsif params[:category_id]
        @catalogs = Category.find(params[:category_id]).catalogs
      else
        @catalogs = Catalog.all
      end
    end

    def catalog_params
      params.require(:catalog).permit(:title, :category_id, :genre_id)
    end
end
