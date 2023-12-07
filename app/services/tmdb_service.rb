# frozen_string_literal: true

class TmdbService
  def initialize(catalog)
    @catalog = catalog
  end

  def execute
    {
      catalog_id: @catalog.id,
      original_title:,
      release_date:,
      overview:,
      vote_average:,
      vote_count:,
      image_url:,
      cast:
    }
  end

  private

  def original_title
    @original_title ||= search_data['original_title'] || search_data['original_name']
  end

  def release_date
    @release_date ||= I18n.l(Date.parse(search_data['release_date'] || search_data['first_air_date']))
  rescue StandardError
    nil
  end

  def overview
    @overview ||= search_data['overview']
  end

  def vote_average
    @vote_average ||= search_data['vote_average']
  end

  def vote_count
    @vote_count ||= search_data['vote_count']
  end

  def image_url
    @image_url ||= "#{base_image_url}#{search_data['poster_path']}"
  end

  def cast
    @cast ||= credits_data.map do |cast|
      {
        name: cast['name'],
        character: cast['character'],
        profile_path: "#{base_image_url}#{cast['profile_path']}"
      }
    end
  end

  def tmdb_id
    @tmdb_id ||= search_data['id']
  end

  def search_data
    net_http = Net::HTTP.get_response(search_uri)

    if net_http.code == '200'
      @search_data ||= JSON.parse(net_http.body).fetch('results', [{}]).first
    else
      @search_data = {}
    end
  end

  def credits_data
    net_http = Net::HTTP.get_response(credits_uri)

    if net_http.code == '200'
      @credits_data ||= JSON.parse(net_http.body).fetch('cast', [{}])
    else
      @credits_data = {}
    end
  end

  def credits_uri
    @credits_uri ||= URI("#{base_url}/#{type}/#{tmdb_id}/credits")
    @credits_uri.query = URI.encode_www_form(
      'api_key' => ENV.fetch('CINE4YOU_API_TMDB_KEY')
    )
    @credits_uri
  end

  def search_uri
    @search_uri ||= URI("#{base_url}/search/#{type}")
    @search_uri.query = URI.encode_www_form(
      'api_key' => ENV.fetch('CINE4YOU_API_TMDB_KEY'),
      'query' => @catalog.title,
      'language' => 'pt-BR'
    )
    @search_uri
  end

  def base_url
    @base_url ||= 'https://api.themoviedb.org/3'
  end

  def base_image_url
    @base_image_url ||= 'https://image.tmdb.org/t/p/w500'
  end

  def type
    @catalog.category.kind == 'filme' ? 'movie' : 'tv'
  end
end
