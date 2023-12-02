# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :catalog
  belongs_to :user

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

  def format_updated_at
    I18n.l(updated_at)
  end

  def as_json(_options = {})
    super(
      root: true,
      except: %i[updated_at created_at],
      methods: %i[good? neutral? bad? format_updated_at],
      include: [user_json]
    )
  end

  private

  def user_json
    { user: { except: %i[created_at updated_at jti] } }
  end
end
