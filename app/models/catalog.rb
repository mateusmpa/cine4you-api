# frozen_string_literal: true

class Catalog < ApplicationRecord
  belongs_to :category
  belongs_to :genre
  has_many :reviews

  def format_title
    title.titleize
  end

  def summed_rating
    reviews.sum(:rating)
  end

  def original_title
    @original_title ||= data['original_title'] || data['original_name']
  end

  def release_date
    @release_date ||= I18n.l(Date.parse(data['release_date'] || data['first_air_date']))
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

  def image_url
    @image_url ||= "#{base_image_url}#{data['poster_path']}"
  end

  def as_json(_options = {})
    super(
      root: true,
      except: %i[title created_at updated_at],
      methods: %i[format_title summed_rating original_title release_date overview vote_average vote_count image_url],
      include: [
        category: category_json,
        genre: genre_json,
        reviews: reviews_json
      ]
    )
  end

  private

  def data
    @data ||= JSON.parse(Net::HTTP.get_response(uri).body).fetch('results', [{}]).first
  end

  def uri
    @uri ||= URI(base_url)
    @uri.query = URI.encode_www_form(
      'api_key' => ENV.fetch('CINE4YOU_API_TMDB_KEY'),
      'query' => title
    )
    @uri
  end

  def base_url
    @base_url ||= "https://api.themoviedb.org/3/search/#{type}"
  end

  def base_image_url
    @base_image_url ||= 'https://image.tmdb.org/t/p/w500'
  end

  def type
    category.kind == 'filme' ? 'movie' : 'tv'
  end

  def category_json
    { except: %i[created_at updated_at] }
  end

  def genre_json
    { except: %i[created_at updated_at] }
  end

  def reviews_json
    {
      except: %i[updated_at created_at],
      methods: %i[good? neutral? bad? format_created_at]
    }
  end
end
