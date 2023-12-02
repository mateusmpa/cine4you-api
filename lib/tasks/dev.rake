# frozen_string_literal: true

namespace :dev do
  desc 'Creates fake reviews for catalogs'
  task fake_reviews: :environment do
    puts 'Creating reviews...'

    5.times do |_i|
      User.create!(
        email: Faker::Internet.email,
        name: Faker::Name.name,
        password: '123456'
      )
    end

    Catalog.all.each do |catalog|
      rand(1..10).times do |_i|
        Review.create!(
          catalog_id: catalog.id,
          user_id: User.all.sample.id,
          rating: rand(1..5),
          comment: Faker::Lorem.paragraph(sentence_count: rand(1..5))
        )
      end
    end

    puts 'Reviews created successfully!'
  end
end
