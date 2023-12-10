# frozen_string_literal: true

FactoryBot.define do
  factory :genre do
    kind { Faker::Lorem.word }
  end
end
