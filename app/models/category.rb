class Category < ApplicationRecord
  has_many :catalogs

  def as_json(options={})
    super(
      root: true,
      except: [:created_at, :updated_at],
      include: [
        {
          catalogs: {
            except: [:created_at, :updated_at],
            methods: [:summed_rating]
          }
        }
      ]
    )
  end
end
