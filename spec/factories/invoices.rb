FactoryBot.define do
  factory :invoice do
    status { "MyString" }
    merchant { nil }
    customer { nil }
  end
end
