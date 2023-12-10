# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  include ApiHelper

  describe 'GET #index' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
      @current_user_reviews = create_list(:review, rand(1..9), user_id: @current_user.id, catalog_id: @catalog.id)
      other_user = create :user
      @other_user_reviews = create_list(:review, rand(1..9), user_id: other_user.id, catalog_id: @catalog.id)
      @reviews = @current_user_reviews + @other_user_reviews
    end

    context 'when user is logged in' do
      before(:each) { authenticated_header(request, @current_user) }

      let(:jwt_token) { JWT.encode({ user_id: @current_user.id }, ENV.fetch('CINE4YOU_API_DEVISE_SECRET_KEY')) }

      it 'returns http success' do
        get :index, params: { catalog_id: @catalog.id }
        expect(response).to have_http_status(:success)
      end

      it 'returns current_user_reviews' do
        get :index, params: { catalog_id: @catalog.id }
        expect(JSON.parse(response.body)['current_user_reviews'].size).to eq(@current_user_reviews.size)
      end

      it 'returns other_user_reviews' do
        get :index, params: { catalog_id: @catalog.id }
        expect(JSON.parse(response.body)['other_reviews'].size).to eq(@other_user_reviews.size)
      end
    end

    context 'when user is not logged in' do
      it 'returns http success' do
        get :index, params: { catalog_id: @catalog.id }
        expect(response).to have_http_status(:success)
      end

      it 'returns all reviews' do
        get :index, params: { catalog_id: @catalog.id }
        expect(JSON.parse(response.body)['other_reviews'].size).to eq(@reviews.size)
      end
    end
  end

  describe 'GET #show' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
      @review = create :review, user_id: @current_user.id, catalog_id: @catalog.id
    end

    it 'returns http success' do
      get :show, params: { catalog_id: @catalog.id, id: @review.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct review' do
      get :show, params: { catalog_id: @catalog.id, id: @review.id }
      expect(JSON.parse(response.body)['review']['id']).to eq(@review.id)
    end
  end

  describe 'POST #create' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
    end

    let(:review_params) do
      {
        rating: 5,
        comment: Faker::Lorem.paragraph
      }
    end

    context 'when user is logged in' do
      before(:each) { authenticated_header(request, @current_user) }

      it 'returns http created' do
        post :create, params: { catalog_id: @catalog.id, review: review_params }
        expect(response).to have_http_status(:created)
      end

      it 'creates a new review' do
        expect do
          post :create, params: { catalog_id: @catalog.id, review: review_params }
        end.to change(Review, :count).by(1)
      end
    end

    context 'when user is not logged in' do
      it 'returns http unauthorized' do
        post :create, params: { catalog_id: @catalog.id, review: review_params }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not create a new review' do
        expect do
          post :create, params: { catalog_id: @catalog.id, review: review_params }
        end.not_to change(Review, :count)
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
      @review = create :review, user_id: @current_user.id, catalog_id: @catalog.id
    end

    let(:review_params) do
      {
        rating: 5,
        comment: Faker::Lorem.paragraph
      }
    end

    context 'when user is logged in' do
      before(:each) { authenticated_header(request, @current_user) }

      it 'returns http success' do
        put :update, params: { catalog_id: @catalog.id, id: @review.id, review: review_params }
        expect(response).to have_http_status(:success)
      end

      it 'updates the review' do
        put :update, params: { catalog_id: @catalog.id, id: @review.id, review: review_params }
        expect(@review.reload.rating).to eq(review_params[:rating])
      end
    end

    context 'when user is not logged in' do
      it 'returns http unauthorized' do
        put :update, params: { catalog_id: @catalog.id, id: @review.id, review: review_params }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not update the review' do
        put :update, params: { catalog_id: @catalog.id, id: @review.id, review: review_params }
        expect(@review.reload.rating).not_to eq(review_params[:rating])
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
      @review = create :review, user_id: @current_user.id, catalog_id: @catalog.id
    end

    context 'when user is logged in' do
      before(:each) { authenticated_header(request, @current_user) }

      it 'returns http success' do
        delete :destroy, params: { catalog_id: @catalog.id, id: @review.id }
        expect(response).to have_http_status(:success)
      end

      it 'deletes the review' do
        expect do
          delete :destroy, params: { catalog_id: @catalog.id, id: @review.id }
        end.to change(Review, :count).by(-1)
      end
    end

    context 'when user is not logged in' do
      it 'returns http unauthorized' do
        delete :destroy, params: { catalog_id: @catalog.id, id: @review.id }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not delete the review' do
        expect do
          delete :destroy, params: { catalog_id: @catalog.id, id: @review.id }
        end.not_to change(Review, :count)
      end
    end
  end

  describe 'GET #good' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
      @good_reviews = create_list(:review, rand(1..9), rating: 5, catalog_id: @catalog.id, user_id: @current_user.id)
      @bad_reviews = create_list(:review, rand(1..9), rating: 1, catalog_id: @catalog.id, user_id: @current_user.id)
      @neutral_reviews = create_list(:review, rand(1..9), rating: 3, catalog_id: @catalog.id, user_id: @current_user.id)
      @reviews = @good_reviews + @bad_reviews + @neutral_reviews
    end

    it 'returns http success' do
      get :good, params: { catalog_id: @catalog.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns good reviews' do
      get :good, params: { catalog_id: @catalog.id }
      expect(JSON.parse(response.body).size).to eq(@good_reviews.size)
    end
  end

  describe 'GET #bad' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
      @good_reviews = create_list(:review, rand(1..9), rating: 5, catalog_id: @catalog.id, user_id: @current_user.id)
      @bad_reviews = create_list(:review, rand(1..9), rating: 1, catalog_id: @catalog.id, user_id: @current_user.id)
      @neutral_reviews = create_list(:review, rand(1..9), rating: 3, catalog_id: @catalog.id, user_id: @current_user.id)
      @reviews = @good_reviews + @bad_reviews + @neutral_reviews
    end

    it 'returns http success' do
      get :bad, params: { catalog_id: @catalog.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns bad reviews' do
      get :bad, params: { catalog_id: @catalog.id }
      expect(JSON.parse(response.body).size).to eq(@bad_reviews.size)
    end
  end

  describe 'GET #neutral' do
    before(:each) do
      category = create :category
      genre = create :genre
      @catalog = create :catalog, category_id: category.id, genre_id: genre.id
      @current_user = create :user
      @good_reviews = create_list(:review, rand(1..9), rating: 5, catalog_id: @catalog.id, user_id: @current_user.id)
      @bad_reviews = create_list(:review, rand(1..9), rating: 1, catalog_id: @catalog.id, user_id: @current_user.id)
      @neutral_reviews = create_list(:review, rand(1..9), rating: 3, catalog_id: @catalog.id, user_id: @current_user.id)
      @reviews = @good_reviews + @bad_reviews + @neutral_reviews
    end

    it 'returns http success' do
      get :neutral, params: { catalog_id: @catalog.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns neutral reviews' do
      get :neutral, params: { catalog_id: @catalog.id }
      expect(JSON.parse(response.body).size).to eq(@neutral_reviews.size)
    end
  end
end
