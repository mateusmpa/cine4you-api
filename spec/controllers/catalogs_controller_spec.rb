# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatalogsController, type: :controller do
  describe 'GET #index' do
    before do
      genre = create :genre
      category = create :category
      @catalogs = create_list(:catalog, rand(1..9), genre_id: genre.id, category_id: category.id)

      @catalogs.each do |catalog|
        allow(Net::HTTP)
          .to receive(:get_response)
          .with(
            URI(
              'https://api.themoviedb.org/3/search/tv?' \
              "api_key=#{ENV.fetch('CINE4YOU_API_TMDB_KEY', nil)}&query=#{catalog.title}&language=pt-BR"
            )
          )
          .and_return(instance_double(Net::HTTPOK, code: '200', body: { 'results' => [{}] }.to_json))
      end
    end

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns all catalogs' do
      get :index, params: { per: @catalogs.size }
      expect(JSON.parse(response.body)['results'].size).to eq(@catalogs.size)
    end
  end

  describe 'GET #show' do
    before do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Net::HTTP)
        .to receive(:get_response)
        .with(
          URI(
            'https://api.themoviedb.org/3/search/tv?' \
            "api_key=#{ENV.fetch('CINE4YOU_API_TMDB_KEY', nil)}&query=#{@catalog.title}&language=pt-BR"
          )
        )
        .and_return(instance_double(Net::HTTPOK, code: '200', body: { 'results' => [{}] }.to_json))
    end

    it 'returns http success' do
      get :show, params: { id: @catalog.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct catalog' do
      get :show, params: { id: @catalog.id }
      expect(JSON.parse(response.body)['catalog']['id']).to eq(@catalog.id)
    end
  end

  describe 'GET #suggestions' do
    before do
      genre = create :genre
      category = create :category
      @catalogs = create_list(:catalog, rand(1..9), genre_id: genre.id, category_id: category.id)

      @catalogs.each do |catalog|
        allow(Net::HTTP)
          .to receive(:get_response)
          .with(
            URI(
              'https://api.themoviedb.org/3/search/tv?' \
              "api_key=#{ENV.fetch('CINE4YOU_API_TMDB_KEY', nil)}&query=#{catalog.title}&language=pt-BR"
            )
          )
          .and_return(instance_double(Net::HTTPOK, code: '200', body: { 'results' => [{}] }.to_json))
      end

      @suggested_catalogs = rand(1..9).times.map { @catalogs.sample }.uniq
      user = create :user
      @suggested_catalogs.each { |catalog| create :review, catalog_id: catalog.id, rating: 5, user_id: user.id }
    end

    it 'returns http success' do
      get :suggestions
      expect(response).to have_http_status(:success)
    end

    it 'returns all catalogs' do
      get :suggestions, params: { per: @catalogs.size }
      expect(JSON.parse(response.body).size).to eq(@suggested_catalogs.size)
    end
  end
end
