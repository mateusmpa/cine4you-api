# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchCatalogsFromImdbWorker, type: :worker do
  describe '#perform' do
    subject { described_class.new.perform }

    let(:genre) { create :genre }
    let(:category) { create :category }
    let(:catalogs) { create_list(:catalog, rand(1..9), genre_id: genre.id, category_id: category.id) }

    it 'calls SearchCatalogFromImdbWorker for each catalog' do
      catalogs.each do |catalog|
        expect(SearchCatalogFromImdbWorker).to receive(:perform_async).with(catalog.id)
      end

      subject
    end
  end
end
