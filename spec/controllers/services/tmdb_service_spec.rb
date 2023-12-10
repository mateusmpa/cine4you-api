# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TmdbService do
  describe '#execute' do
    before do
      genre = create :genre
      category = create :category, kind: kind
      @catalog = create :catalog, genre_id: genre.id, category_id: category.id

      allow(Net::HTTP)
        .to receive(:get_response)
        .with(
          URI(
            "https://api.themoviedb.org/3/search/#{type}?" \
            "api_key=#{ENV.fetch('CINE4YOU_API_TMDB_KEY', nil)}&query=#{@catalog.title}&language=pt-BR"
          )
        )
        .and_return(instance_double(Net::HTTPOK, code: '200', body: { 'results' => results }.to_json))

      allow(Net::HTTP)
        .to receive(:get_response)
        .with(
          URI(
            "https://api.themoviedb.org/3/#{type}/#{tmdb_id}/credits?api_key=#{ENV.fetch('CINE4YOU_API_TMDB_KEY', nil)}"
          )
        )
        .and_return(instance_double(Net::HTTPOK, code: '200', body: { 'cast' => cast }.to_json))
    end

    subject { described_class.new(@catalog).execute }

    let(:tmdb_id) { 1 }
    let(:original_title) { 'The Movie' }
    let(:release_date) { '2022-01-01' }
    let(:overview) { 'The Movie Overview' }
    let(:vote_average) { '9.9' }
    let(:vote_count) { '999' }
    let(:poster_path) { '/poster_path.jpg' }
    let(:name) { 'Actor 1' }
    let(:character) { 'Character 1' }
    let(:profile_path) { '/profile_path.jpg' }

    let(:results) do
      [
        {
          id: tmdb_id,
          original_title: original_title,
          release_date: release_date,
          overview: overview,
          vote_average: vote_average,
          vote_count: vote_count,
          poster_path: poster_path
        }
      ]
    end

    let(:cast) do
      [
        {
          name: name,
          character: character,
          profile_path: profile_path
        }
      ]
    end

    let(:data) do
      {
        catalog_id: @catalog.id,
        original_title: original_title,
        release_date: I18n.l(Date.parse(release_date)),
        overview: overview,
        vote_average: vote_average,
        vote_count: vote_count,
        image_url: "https://image.tmdb.org/t/p/w500#{poster_path}",
        cast: [
          {
            name: name,
            character: character,
            profile_path: "https://image.tmdb.org/t/p/w500#{profile_path}"
          }
        ]
      }
    end

    context 'when the catalog is a movie' do
      let(:kind) { 'filme' }
      let(:type) { 'movie' }

      it 'returns the expected movie data' do
        expect(subject).to eq(data)
      end
    end

    context 'when the catalog is a tv show' do
      let(:kind) { 'série' }
      let(:type) { 'tv' }

      it 'returns the expected serie data' do
        expect(subject).to eq(data)
      end
    end
  end
end
