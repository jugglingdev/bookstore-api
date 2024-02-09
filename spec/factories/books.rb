FactoryBot.define do
    factory :book do
      title { Faker::Lorem.sentence }
      author
    end
end