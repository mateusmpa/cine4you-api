# frozen_string_literal: true

class CatalogSuggestionsService
  def initialize(catalogs)
    @catalogs = catalogs
  end

  def execute
    @catalogs.select { |catalog| catalog.summed_rating == max_summed_rating }
  end

  private

  def max_summed_rating
    @catalogs.max_by(&:summed_rating).summed_rating
  end
end
