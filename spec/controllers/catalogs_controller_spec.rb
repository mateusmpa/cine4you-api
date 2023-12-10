# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CatalogsController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalogs = create_list(:catalog, rand(1..9), genre_id: genre.id, category_id: category.id)

      @catalogs.each do |catalog|
        allow(Redis)
          .to receive(:new)
          .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
          .and_return(
            instance_double(
              Redis,
              get: {
                id: catalog.id,
                original_title: Faker::Movie.title,
                release_date: '2022-01-01',
                overview: Faker::Lorem.paragraph,
                vote_average: '9.9',
                vote_count: '999',
                poster_path: '/poster_path.jpg',
                cast: [
                  {
                    name: Faker::Name.name,
                    character: Faker::Name.name,
                    profile_path: '/profile_path.jpg'
                  }
                ]
              }.to_json
            )
          )
      end
    end

    let(:redis) { instance_double(Redis, get: double) }

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
      rand(1..9)
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(
          instance_double(
            Redis,
            get: {
              id: @catalog.id,
              original_title: Faker::Movie.title,
              release_date: '2022-01-01',
              overview: Faker::Lorem.paragraph,
              vote_average: '9.9',
              vote_count: '999',
              poster_path: '/poster_path.jpg',
              cast: [
                {
                  name: Faker::Name.name,
                  character: Faker::Name.name,
                  profile_path: '/profile_path.jpg'
                }
              ]
            }.to_json
          )
        )
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
        allow(Redis)
          .to receive(:new)
          .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
          .and_return(
            instance_double(
              Redis,
              get: {
                id: catalog.id,
                original_title: Faker::Movie.title,
                release_date: '2022-01-01',
                overview: Faker::Lorem.paragraph,
                vote_average: '9.9',
                vote_count: '999',
                poster_path: '/poster_path.jpg',
                cast: [
                  {
                    name: Faker::Name.name,
                    character: Faker::Name.name,
                    profile_path: '/profile_path.jpg'
                  }
                ]
              }.to_json
            )
          )
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
