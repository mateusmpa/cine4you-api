# frozen_string_literal: true

FactoryBot.define do
  factory :catalog do
    title { Faker::Lorem.word }
  end
end
