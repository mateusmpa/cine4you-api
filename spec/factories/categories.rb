# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    kind { Faker::Lorem.word }
  end
end
