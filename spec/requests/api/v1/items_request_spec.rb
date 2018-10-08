require 'rails_helper'

describe 'Items API' do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end
  it "can get one item by its ID" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["id"]).to eq(id)
  end
  it 'can find item by id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?id=#{item.id}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item.id)
  end
  it 'can find item by description' do
    merchant = create(:merchant)
    description = "holds reed to mouthpiece"
    item_1 = create(:item,
    description: description, merchant_id: merchant.id)
    item_2 = create(:item, description: "pedal board case", merchant_id: merchant.id)

    get "/api/v1/items/find?description=#{item_1.description}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item_1.id)
  end
  it 'can find item by unit_price' do
    merchant = create(:merchant)
    unit_price = 1400
    item_1 = create(:item,
    unit_price: 1200, merchant_id: merchant.id)
    item_2 = create(:item, unit_price: unit_price, merchant_id: merchant.id)

    get "/api/v1/items/find?unit_price=#{item_2.unit_price}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item_2.id)
  end
  it 'can find item by created at' do
    merchant = create(:merchant)
    created_at = '2018-06-26 16:32:13 UTC'
    item_1 = create(:item, merchant_id: merchant.id, created_at: '2018-10-03 04:17:06 UTC')
    item_2 = create(:item, merchant_id: merchant.id, created_at: created_at)

    get "/api/v1/items/find?created_at=#{created_at}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item_2.id)
  end
  it 'can find item by updated at' do
    merchant = create(:merchant)
    updated_at = '2018-06-26 16:32:13 UTC'
    item_1 = create(:item, merchant_id: merchant.id, updated_at: '2018-10-03 04:17:06 UTC')
    item_2 = create(:item, merchant_id: merchant.id, updated_at: updated_at)

    get "/api/v1/items/find?updated_at=#{updated_at}"

    response_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_item["id"]).to eq(item_2.id)
  end
  it 'can find all items by id' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)


    get "/api/v1/items/find_all?id=#{item_2.id}"

    response_items = JSON.parse(response.body)
    item = response_items.first

    expect(response).to be_successful
    expect(item["id"]).to eq(item_2.id)
  end
  it 'can find all items by name' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "ring")
    item_2 = create(:item, merchant_id: merchant.id, name: "book")


    get "/api/v1/items/find_all?name=#{item_2.name}"

    response_items = JSON.parse(response.body)
    item = response_items.first

    expect(response).to be_successful
    expect(item["id"]).to eq(item_2.id)
  end
  it 'can find all items by description' do
    merchant = create(:merchant)
    description = "holds reed to mouthpiece"
    item_1 = create(:item,
    description: description, merchant_id: merchant.id)
    item_2 = create(:item, description: "pedal board case", merchant_id: merchant.id)
    item_3 = create(:item,
    description: description, merchant_id: merchant.id)

    get "/api/v1/items/find_all?description=#{item_1.description}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.count).to eq(2)
  end
  it 'can find all items by unit_price' do
    merchant = create(:merchant)
    unit_price = 1400
    item_1 = create(:item,
    unit_price: unit_price, merchant_id: merchant.id)
    item_2 = create(:item, unit_price: 1200, merchant_id: merchant.id)
    item_3 = create(:item,
    unit_price: unit_price, merchant_id: merchant.id)

    get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.count).to eq(2)
  end
  it 'can find all items by created_at' do
    merchant = create(:merchant)
    created_at = '2018-06-26 16:32:13 UTC'
    item_1 = create(:item,
    created_at: created_at, merchant_id: merchant.id)
    item_2 = create(:item, created_at: '2018-10-03 16:32:13 UTC', merchant_id: merchant.id)
    item_3 = create(:item,
    created_at: created_at, merchant_id: merchant.id)

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.count).to eq(2)
  end
  it 'can find all items by updated_at' do
    merchant = create(:merchant)
    updated_at = '2018-06-26 16:32:13 UTC'
    item_1 = create(:item,
    updated_at: updated_at, merchant_id: merchant.id)
    item_2 = create(:item, updated_at: '2018-10-03 16:32:13 UTC', merchant_id: merchant.id)
    item_3 = create(:item,
    updated_at: updated_at, merchant_id: merchant.id)

    get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"

    response_items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_items.count).to eq(2)
  end
  it 'can find a random item' do
    merchant = create(:merchant)
    create_list(:item, 4, merchant_id: merchant.id)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item.count).to eq(1)
  end
  it 'can get item merchant' do
    id = create(:merchant).id
    item = create(:item, merchant_id: id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(id)
  end
  it 'can get item invoice_items' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:invoice_item, 4, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(4)
  end
end
