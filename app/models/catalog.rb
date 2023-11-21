class Catalog < ApplicationRecord
  belongs_to :category
  belongs_to :genre
  has_many :reviews

  def summed_rating
    self.reviews.sum(:rating)
  end

  def as_json(options={})
    super(
      root: true,
      except: [:created_at, :updated_at],
      methods: [:summed_rating],
      include: [
        {
          category: {
            except: [:created_at, :updated_at]
          }
        },
        {
          genre: {
            except: [:created_at, :updated_at]
          }
        },
        {
          reviews: {
            except: [:updated_at],
            methods: [:good?, :neutral?, :bad?]
          }
        }
      ]
    )
  end
end
