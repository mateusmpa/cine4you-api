class Review < ApplicationRecord
  belongs_to :catalog

  validates :rating, inclusion: { in: 0..5 }

  def good?
    self.rating > 3
  end

  def neutral?
    self.rating == 3
  end

  def bad?
    self.rating < 3
  end

  def format_created_at
    I18n.l(self.created_at)
  end

  def as_json(options={})
    super(
      root: true,
      except: [:updated_at, :created_at],
      methods: [:good?, :neutral?, :bad?, :format_created_at],
      include: [
        {
          catalog: {
            except: [:created_at, :updated_at],
            methods: [:summed_rating]
          }
        }
      ]
    )
  end
end
