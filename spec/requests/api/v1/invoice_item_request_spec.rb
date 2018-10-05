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

  it 'can find invoice_item by id' do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)


    get "/api/v1/invoice_items/find?id=#{invoice_item_2.id}"

    response_invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_item["id"]).to eq(invoice_item_2.id)
  end
  it 'can find invoice_item by quantity' do
    quantity = 100
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 20)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: quantity)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item_2.quantity}"

    response_invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_item["id"]).to eq(invoice_item_2.id)
  end
  it 'can find item by unit_price' do
    unit_price = 1400
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1200)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: unit_price)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item_2.unit_price}"

    response_invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_item["id"]).to eq(invoice_item_2.id)
  end
  it 'can find item by created at' do
    created_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, created_at: '2018-10-04 16:32:13 UTC')
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, created_at: created_at)

    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    response_invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_item["id"]).to eq(invoice_item_2.id)
  end
  it 'can find item by updated at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, updated_at: '2018-10-04 16:32:13 UTC')
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, updated_at: updated_at)

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    response_invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_item["id"]).to eq(invoice_item_2.id)
  end
  it 'can find all invoice items by id' do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)


    get "/api/v1/invoice_items/find_all?id=#{invoice_item_2.id}"

    response_invoice_items = JSON.parse(response.body)
    invoice_item = response_invoice_items.first

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(invoice_item_2.id)
  end
  it 'can find all items by quantity' do
    quantity = 100
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 20)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: quantity)
    invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: quantity)


    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_2.quantity}"

    response_invoice_items = JSON.parse(response.body)
    invoice_item = response_invoice_items.first

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(invoice_item_2.id)
  end
  it 'can find all items by unit_price' do
    unit_price = 1400
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1200)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: unit_price)
    invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: unit_price)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item_2.unit_price}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.count).to eq(2)
  end
  it 'can find all items by created_at' do
    created_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, created_at: '2018-10-04 16:32:13 UTC')
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, created_at: created_at)
    invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, created_at: created_at)

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_2.created_at}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.count).to eq(2)
  end
  it 'can find all items by updated_at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, updated_at: '2018-10-04 16:32:13 UTC')
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, updated_at: updated_at)
    invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, updated_at: updated_at)

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item_2.updated_at}"

    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice_items.count).to eq(2)
  end
  it 'can find a random invoice item' do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    create_list(:invoice_item, 4, item_id: item_1.id, invoice_id: invoice_1.id)

    get "/api/v1/invoice_items/random"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.count).to eq(1)
  end
end
