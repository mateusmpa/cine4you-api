# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    before { @categories = create_list(:category, rand(1..9)) }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all categories' do
      get :index
      expect(JSON.parse(response.body).size).to eq(@categories.size)
    end
  end

  describe 'GET #show' do
    context 'when catalog_id is not present' do
      before { @category = create :category }

      it 'returns http success' do
        get :show, params: { id: @category.id }
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct category' do
        get :show, params: { id: @category.id }
        expect(JSON.parse(response.body)['category']['id']).to eq(@category.id)
      end
    end

    context 'when catalog_id is present' do
      before do
        @genre = create :genre
        @category = create :category
        @catalog = create :catalog, genre_id: @genre.id, category_id: @category.id
      end

      it 'returns http success' do
        get :show, params: { catalog_id: @catalog.id, id: @category.id }
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct category' do
        get :show, params: { catalog_id: @catalog.id, id: @category.id }
        expect(JSON.parse(response.body)['category']['id']).to eq(@category.id)
      end
    end
  end
end
