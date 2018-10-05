require 'rails_helper'

describe 'Customers API' do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
  it "can get one customer by its ID" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["id"]).to eq(id)
  end
  it 'can find customer by id' do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end
  it 'can find customer by first name' do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end
  it 'can find customer by last name' do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer.id)
  end
  it 'can find customer by created at' do
    created_at = '2018-06-26 16:32:13 UTC'
    customer_1 = create(:customer, created_at: '2018-10-03 04:17:06 UTC')
    customer_2 = create(:customer, created_at: created_at)

    get "/api/v1/customers/find?created_at=#{created_at}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer_2.id)
  end
  it 'can find customer by updated at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    customer_1 = create(:customer, updated_at: '2018-10-03 04:17:06 UTC')
    customer_2 = create(:customer, updated_at: updated_at)

    get "/api/v1/customers/find?updated_at=#{updated_at}"

    response_customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customer["id"]).to eq(customer_2.id)
  end
  it 'can find all customers by id' do
    customer = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer.id}"

    response_customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customers.first["id"]).to eq(customer.id)
  end
  it 'can find all by first name' do
    customer_1 = create(:customer, first_name: 'Jeremy')
    customer_2 = create(:customer, first_name: 'Alex')
    customer_3 = create(:customer, first_name: 'Jeremy')

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    response_customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customers.first["id"]).to eq(customer_1.id)
    expect(response_customers.count).to eq(2)
  end
  it 'can find all by last name' do
    customer_1 = create(:customer, last_name: 'Parnacher')
    customer_2 = create(:customer, last_name: 'Easton')
    customer_3 = create(:customer, last_name: 'Parnacher')

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    response_customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customers.last["id"]).to eq(customer_3.id)
    expect(response_customers.count).to eq(2)
  end
  it 'can find all customers created at' do
    created_at = '2018-06-26 16:32:13 UTC'
    customer_1 = create(:customer, created_at: '2018-10-03 04:17:06 UTC')
    customer_2 = create(:customer, created_at: created_at)
    customer_3 = create(:customer, created_at: created_at)

    get "/api/v1/customers/find_all?created_at=#{created_at}"

    response_customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customers.first["id"]).to eq(customer_2.id)
    expect(response_customers.count).to eq(2)
  end
  it 'can find all customers updated at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    customer_1 = create(:customer, updated_at: '2018-10-03 04:17:06 UTC')
    customer_2 = create(:customer, updated_at: updated_at)
    customer_3 = create(:customer, updated_at: updated_at)

    get "/api/v1/customers/find_all?updated_at=#{updated_at}"

    response_customers = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_customers.first["id"]).to eq(customer_2.id)
    expect(response_customers.count).to eq(2)
  end
  it 'can find a random customer' do
    create_list(:customer, 4)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.count).to eq(1)
  end

end
