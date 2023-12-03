# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  describe 'GET #index' do
    before { @genres = create_list(:genre, rand(1..9)) }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all genres' do
      get :index
      expect(JSON.parse(response.body).size).to eq(@genres.size)
    end
  end

  describe 'GET #show' do
    context 'when catalog_id is not present' do
      before { @genre = create :genre }

      it 'returns http success' do
        get :show, params: { id: @genre.id }
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct genre' do
        get :show, params: { id: @genre.id }
        expect(JSON.parse(response.body)['genre']['id']).to eq(@genre.id)
      end
    end

    context 'when catalog_id is present' do
      before do
        @genre = create :genre
        @category = create :category
        @catalog = create :catalog, genre_id: @genre.id, category_id: @category.id
      end

      it 'returns http success' do
        get :show, params: { catalog_id: @catalog.id, id: @genre.id }
        expect(response).to have_http_status(:success)
      end

      it 'returns the correct genre' do
        get :show, params: { catalog_id: @catalog.id, id: @genre.id }
        expect(JSON.parse(response.body)['genre']['id']).to eq(@genre.id)
      end
    end
  end
end
