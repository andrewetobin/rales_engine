require 'rails_helper'

describe 'Invoices API' do
  it "sends a list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant.id)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end
  it "can get one item by its ID" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer_id: customer.id, merchant_id: merchant.id).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["id"]).to eq(id)
  end
end
