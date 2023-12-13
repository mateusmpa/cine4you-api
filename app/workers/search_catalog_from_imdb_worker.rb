# frozen_string_literal: true

class SearchCatalogFromImdbWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'imdb', retry: 5

  def perform(catalog_id)
    catalog = Catalog.find(catalog_id)
    tmdb_data = TmdbService.new(catalog).execute

    Redis.new(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil)).set("catalog:#{catalog.id}", tmdb_data.to_json)
  end
end
