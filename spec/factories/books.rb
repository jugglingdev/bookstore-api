FactoryBot.define do
    factory :book do
      title { Faker::Lorem.paragraph_by_chars(number: 50, supplemental: false) }
      author
    end
end