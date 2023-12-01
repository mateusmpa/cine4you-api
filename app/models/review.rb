# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :catalog

  validates :rating, inclusion: { in: 0..5 }

  def good?
    rating > 3
  end

  def neutral?
    rating == 3
  end

  def bad?
    rating < 3
  end

  def format_created_at
    I18n.l(created_at)
  end

  def as_json(_options = {})
    super(
      root: true,
      except: %i[updated_at created_at],
      methods: %i[good? neutral? bad? format_created_at],
      include: [catalog_json]
    )
  end

  private

  def catalog_json
    { catalog: { except: %i[created_at updated_at], methods: [:summed_rating] } }
  end
end
