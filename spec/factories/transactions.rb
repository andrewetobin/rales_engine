FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number "4243943726315469"
    result "success"
    created_at "2018-10-13 19:32:23 UTC".to_date
    updated_at "2018-10-13 19:32:23 UTC".to_date
  end
end
