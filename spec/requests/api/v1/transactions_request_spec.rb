require 'rails_helper'

describe 'Transaction Item API' do
  it "sends a list of transactions" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    create_list(:transaction, 3, invoice_id: invoice_1.id)


    get '/api/v1/transactions'

    transactions = JSON.parse(response.body, symbolize_names: true)
    transaction = transactions.first

    expect(transactions.count).to eq(3)
    expect(transaction).to have_key(:credit_card_number)
    expect(transaction).to have_key(:result)
  end
  it "can get one invoice item by its ID" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    id = create(:transaction, invoice_id: invoice_1.id).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction['id']).to eq(id)
  end
end
