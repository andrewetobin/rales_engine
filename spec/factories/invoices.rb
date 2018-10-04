FactoryBot.define do
  factory :invoice do
    merchant
   customer
   status "Shipped"
   created_at "2018-10-03 20:07:34"
   updated_at "2018-10-03 20:07:34"
  end
end
