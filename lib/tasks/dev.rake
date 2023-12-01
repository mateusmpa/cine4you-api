# frozen_string_literal: true

namespace :dev do
  desc 'Creates fake reviews for catalogs'
  task fake_reviews: :environment do
    puts 'Creating reviews...'

    Catalog.all.each do |catalog|
      rand(1..10).times do |_i|
        Review.create!(
          catalog_id: catalog.id,
          name: Faker::Name.name,
          rating: rand(1..5),
          comment: Faker::Lorem.paragraph(sentence_count: rand(1..5))
        )
      end
    end

    puts 'Reviews created successfully!'
  end
end
