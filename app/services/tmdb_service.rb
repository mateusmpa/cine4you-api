class TmdbService
  def initialize(catalog)
    @catalog = catalog
  end

  def execute
    {
      original_title: original_title,
      release_date: release_date,
      overview: overview,
      vote_average: vote_average,
      vote_count: vote_count
    }
  end

  private

  def original_title
    @original_title ||= data['original_title'] || data['original_name']
  end

  def release_date
    @release_date ||= data['release_date'] || data['first_air_date']
  end

  def overview
    @overview ||= data['overview']
  end

  def vote_average
    @vote_average ||= data['vote_average']
  end

  def vote_count
    @vote_count ||= data['vote_count']
  end

  def data
    @data ||= JSON.parse(Net::HTTP.get_response(uri).body).fetch('results', [{}]).first
  end

  def uri
    @uri ||= URI(base_url)
    @uri.query = URI.encode_www_form(
      'api_key' => ENV.fetch('CINE4YOU_API_TMDB_KEY'),
      'query' => @catalog.title
    )
    @uri
  end

  def base_url
    @base_url ||= "https://api.themoviedb.org/3/search/#{type}"
  end

  def type
    @catalog.category.kind == 'filme' ? 'movie' : 'tv'
  end
end
