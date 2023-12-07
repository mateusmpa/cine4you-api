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
    @original_title ||= tmdb_from_redis['original_title']
  end

  def release_date
    @release_date ||= tmdb_from_redis['release_date']
  end

  def overview
    @overview ||= tmdb_from_redis['overview']
  end

  def vote_average
    @vote_average ||= tmdb_from_redis['vote_average']
  end

  def vote_count
    @vote_count ||= tmdb_from_redis['vote_count']
  end

  def image_url
    @image_url ||= tmdb_from_redis['image_url']
  end

  def cast
    @cast ||= tmdb_from_redis['cast']
  end

  def as_json(options = {})
    super(
      root: true,
      except: %i[title created_at updated_at],
      methods: %i[format_title summed_rating original_title release_date overview vote_average vote_count image_url],
      include: [category: category_json, genre: genre_json]
    ).tap { |json| json[:cast] = cast if options[:include_cast] }
  end

  private

  def tmdb_from_redis
    @tmdb_from_redis ||= JSON.parse(Redis.new(url: ENV.fetch('CINE4YOU_API_REDIS_URL', nil)).get("catalog:#{id}"))
  end

  def category_json
    { except: %i[created_at updated_at] }
  end

  def genre_json
    { except: %i[created_at updated_at] }
  end
end
