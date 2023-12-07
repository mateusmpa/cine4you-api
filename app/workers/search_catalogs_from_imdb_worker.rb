# frozen_string_literal: true

class SearchCatalogsFromImdbWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'imdb'

  def perform
    Catalog.all.each do |catalog|
      SearchCatalogFromImdbWorker.perform_async(catalog.id)
    end
  end
end
