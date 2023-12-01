# frozen_string_literal: true

class GenresController < ApplicationController
  before_action :set_genre, only: %i[show]

  def index
    @genres = Genre.all

    render json: @genres
  end

  def show
    render json: @genre
  end

  private

  def set_genre
    if params[:catalog_id]
      @catalog = Catalog.find(params[:catalog_id])
      @genre = @catalog.genre
    else
      @genre = Genre.find(params[:id])
    end
  end

  def genre_params
    params.require(:genre).permit(:kind)
  end
end
