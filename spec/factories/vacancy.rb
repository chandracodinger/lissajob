FactoryBot.define do
  factory :vacancy do
    title { Faker::StarWars.character }
    salary { Faker::Number.number(10) }
    requipment { Faker::Lorem.word }
    description { Faker::Lorem.word }
  	expired { Faker::Date.forward(23) }
  end
end