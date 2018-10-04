require 'rails_helper'

describe 'Merchants API' do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end
  it "can get one item by its ID" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["id"]).to eq(id)
  end
  it 'can find merchant by id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
  it 'can find merchant by name' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end
  it 'can find merchant by created at' do
    created_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant, created_at: '2018-10-03 04:17:06 UTC')
    merchant_2 = create(:merchant, created_at: created_at)

    get "/api/v1/merchants/find?created_at=#{created_at}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant_2.id)
  end
  it 'can find merchant by updated at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant, updated_at: '2018-10-03 04:17:06 UTC')
    merchant_2 = create(:merchant, updated_at: updated_at)

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant_2.id)
  end
  it 'can find all merchants by id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant.id}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant.id)
  end
  it 'can find all by name' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find_all?name=#{merchant.name}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant.id)
  end
  it 'can find all merchants created at' do
    created_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant, created_at: '2018-10-03 04:17:06 UTC')
    merchant_2 = create(:merchant, created_at: created_at)
    merchant_3 = create(:merchant, created_at: created_at)

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant_2.id)
    expect(response_merchants.count).to eq(2)
  end
  it 'can find all merchants updated at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant, updated_at: '2018-10-03 04:17:06 UTC')
    merchant_2 = create(:merchant, updated_at: updated_at)
    merchant_3 = create(:merchant, updated_at: updated_at)

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    response_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchants.first["id"]).to eq(merchant_2.id)
    expect(response_merchants.count).to eq(2)
  end
end
