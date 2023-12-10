# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.word }
    rating { Faker::Number.between(from: 1, to: 5) }
  end
end
