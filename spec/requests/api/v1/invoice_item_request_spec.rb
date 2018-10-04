require 'rails_helper'

describe 'Invoice Item API' do
  it "sends a list of invoice_items" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    create_list(:invoice_item, 3, item_id: item_1.id, invoice_id: invoice_1.id)


      get '/api/v1/invoice_items'

      invoice_items = JSON.parse(response.body)
      invoice_item = invoice_items.first

      expect(response).to be_successful
      expect(invoice_items.count).to eq(3)
      expect(invoice_item).to have_key('item_id')
      expect(invoice_item).to have_key('invoice_id')
      expect(invoice_item).to have_key('quantity')
      expect(invoice_item).to have_key('unit_price')
  end
  it "can get one invoice item by its ID" do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    id = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(id)
    expect(invoice_item).to have_key('item_id')
    expect(invoice_item).to have_key('invoice_id')
    expect(invoice_item).to have_key('quantity')
    expect(invoice_item).to have_key('unit_price')
  end
end
