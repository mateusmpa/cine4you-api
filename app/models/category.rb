# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :catalogs

  def as_json(_options = {})
    super(
      root: true,
      except: %i[created_at updated_at],
      include: [catalogs: { except: %i[created_at updated_at], methods: [:summed_rating] }]
    )
  end
end
