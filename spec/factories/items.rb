FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    unit_price { "9.99" }
    merchant { nil }
  end
end
