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
  it 'can find merchant by name' do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    response_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_merchant["id"]).to eq(merchant.id)
  end

end
