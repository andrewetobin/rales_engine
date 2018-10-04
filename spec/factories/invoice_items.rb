FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity 100
    unit_price 100
    created_at "2018-10-03 20:07:34"
    updated_at "2018-10-03 20:07:34"
  end
end
