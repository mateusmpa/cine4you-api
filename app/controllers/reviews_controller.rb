# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :set_review, only: %i[show]
  before_action :set_catalog, only: %i[index create good bad neutral]

  def index
    @reviews = @catalog.reviews
    @current_user_reviews = current_user.present? ? @reviews.where(user_id: current_user.id) : []
    @other_reviews = @reviews - @current_user_reviews

    render json: { current_user_reviews: @current_user_reviews, other_reviews: @other_reviews }
  end

  def show
    render json: @review
  end

  def create
    @catalog.reviews << current_user.reviews.new(review_params)

    if @catalog.save
      render json: @catalog.reviews, status: :created, location: catalog_reviews_url(@catalog)
    else
      render json: @catalog.errors, status: :unprocessable_entity
    end
  end

  def good
    @reviews = @catalog.reviews.select(&:good?)

    render json: @reviews
  end

  def bad
    @reviews = @catalog.reviews.select(&:bad?)

    render json: @reviews
  end

  def neutral
    @reviews = @catalog.reviews.select(&:neutral?)

    render json: @reviews
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_catalog
    @catalog = Catalog.find(params[:catalog_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :catalog_id)
  end
end
