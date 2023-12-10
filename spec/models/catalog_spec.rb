# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Catalog, type: :model do
  describe '#format_title' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, title: title, genre_id: genre.id, category_id: category.id
    end

    subject { @catalog.format_title }

    let(:title) { 'the matrix' }

    it 'returns the correct title' do
      expect(subject).to eq(title.titleize)
    end
  end

  describe '#summed_rating' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id
      user = create :user
      @reviews = create_list(:review, rand(1..9), catalog_id: @catalog.id, user_id: user.id)
    end

    subject { @catalog.summed_rating }

    let(:rating) { @reviews.sum(&:rating) }

    it 'returns the correct rating' do
      expect(subject).to eq(rating)
    end
  end

  describe '#original_title' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: { 'original_title' => original_title }.to_json))
    end

    subject { @catalog.original_title }

    let(:original_title) { 'The Matrix' }

    it 'returns the correct original_title' do
      expect(subject).to eq(original_title)
    end
  end

  describe '#release_date' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: { 'release_date' => release_date }.to_json))
    end

    subject { @catalog.release_date }

    let(:release_date) { '2022-01-01' }

    it 'returns the correct release_date' do
      expect(subject).to eq(release_date)
    end
  end

  describe '#overview' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: { 'overview' => overview }.to_json))
    end

    subject { @catalog.overview }

    let(:overview) { 'The Matrix Overview' }

    it 'returns the correct overview' do
      expect(subject).to eq(overview)
    end
  end

  describe '#vote_average' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: { 'vote_average' => vote_average }.to_json))
    end

    subject { @catalog.vote_average }

    let(:vote_average) { '9.9' }

    it 'returns the correct vote_average' do
      expect(subject).to eq(vote_average)
    end
  end

  describe '#vote_count' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: { 'vote_count' => vote_count }.to_json))
    end

    subject { @catalog.vote_count }

    let(:vote_count) { '999' }

    it 'returns the correct vote_count' do
      expect(subject).to eq(vote_count)
    end
  end

  describe '#image_url' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: { 'image_url' => image_url }.to_json))
    end

    subject { @catalog.image_url }

    let(:image_url) { 'https://image.tmdb.org/t/p/w500/poster_path.jpg' }

    it 'returns the correct image_url' do
      expect(subject).to eq(image_url)
    end
  end

  describe '#cast' do
    before(:each) do
      genre = create :genre
      category = create :category
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: { 'cast' => cast }.to_json))
    end

    subject { @catalog.cast }

    let(:cast) do
      [
        {
          'name' => 'Actor 1',
          'character' => 'Character 1',
          'profile_path' => 'https://image.tmdb.org/t/p/w500/profile_path.jpg'
        }
      ]
    end

    it 'returns the correct cast' do
      expect(subject).to eq(cast)
    end
  end

  describe '#as_json' do
    before(:each) do
      @genre = create :genre
      @category = create :category
      @catalog = create :catalog, title: title, genre_id: @genre.id, category_id: @category.id
      user = create :user
      @reviews = create_list(:review, rand(1..9), catalog_id: @catalog.id, user_id: user.id)

      allow(Redis)
        .to receive(:new)
        .with(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil))
        .and_return(instance_double(Redis, get: redis_data.to_json))
    end

    let(:title) { 'the matrix' }
    let(:rating) { @reviews.sum(&:rating) }
    let(:original_title) { 'The Matrix' }
    let(:release_date) { '2022-01-01' }
    let(:overview) { 'The Matrix Overview' }
    let(:vote_average) { '9.9' }
    let(:vote_count) { '999' }
    let(:image_url) { 'https://image.tmdb.org/t/p/w500/poster_path.jpg' }
    let(:cast) do
      [
        {
          'name' => 'Actor 1',
          'character' => 'Character 1',
          'profile_path' => 'https://image.tmdb.org/t/p/w500/profile_path.jpg'
        }
      ]
    end

    let(:redis_data) do
      {
        'id' => @catalog.id,
        'original_title' => original_title,
        'release_date' => release_date,
        'overview' => overview,
        'vote_average' => vote_average,
        'vote_count' => vote_count,
        'image_url' => image_url,
        'cast' => cast
      }
    end

    let(:json) do
      {
        'catalog' => {
          'id' => @catalog.id,
          'category_id' => @category.id,
          'genre_id' => @genre.id,
          'format_title' => title.titleize,
          'summed_rating' => rating,
          'original_title' => original_title,
          'release_date' => release_date,
          'overview' => overview,
          'vote_average' => vote_average,
          'vote_count' => vote_count,
          'image_url' => image_url,
          'category' => {
            'id' => @category.id,
            'kind' => @category.kind
          },
          'genre' => {
            'id' => @genre.id,
            'kind' => @genre.kind
          }
        }
      }
    end

    let(:json_with_cast) do
      json.tap { |json| json[:cast] = cast }
    end

    context 'when options is empty' do
      subject { @catalog.as_json }

      it 'returns the correct json' do
        expect(subject).to eq(json)
      end
    end

    context 'when options is include_cast' do
      subject { @catalog.as_json(include_cast: true) }

      it 'returns the correct json' do
        expect(subject).to eq(json_with_cast)
      end
    end
  end
end
