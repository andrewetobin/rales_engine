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
  it "can find by id" do
    id = 12
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, id: 14, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, id: id, invoice_id: invoice_1.id)

    get "/api/v1/transactions/find?id=#{id}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction_2.id)
  end
  it "can find by result" do
    result = "pending"
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, result: "success", invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, result: result, invoice_id: invoice_1.id)

    get "/api/v1/transactions/find?result=#{result}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction_2.id)
  end
  it "can find by credit_card_number" do
    credit_card_number = "4243561278736451"
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, credit_card_number: "4334879348724612", invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, credit_card_number: credit_card_number, invoice_id: invoice_1.id)

    get "/api/v1/transactions/find?credit_card_number=#{credit_card_number}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction_2.id)
  end
  it "can find by credit_card_expiration_date" do
    credit_card_expiration_date = "06/21"
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, credit_card_expiration_date: "07/19", invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, credit_card_expiration_date: credit_card_expiration_date, invoice_id: invoice_1.id)

    get "/api/v1/transactions/find?credit_card_expiration_date=#{credit_card_expiration_date}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction_2.id)
  end
  it "can find by created_at" do
    created_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, created_at: '2018-10-04 16:32:13 UTC', invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, created_at: created_at, invoice_id: invoice_1.id)

    get "/api/v1/transactions/find?created_at=#{created_at}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction_2.id)
  end
  it "can find by updated_at" do
    updated_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, updated_at: '2018-10-04 16:32:13 UTC', invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, updated_at: updated_at, invoice_id: invoice_1.id)

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    response_transaction = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_transaction["id"]).to eq(transaction_2.id)
  end
  it 'can find all transactions by id' do
    id = 12
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, id: 14, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, id: id, invoice_id: invoice_1.id)


    get "/api/v1/transactions/find_all?id=#{transaction_2.id}"

    response_transactions = JSON.parse(response.body)
    transaction = response_transactions.first

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_2.id)
  end
  it 'can find all transactions by result' do
    result = "pending"
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, result: "success", invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, result: result, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, result: result, invoice_id: invoice_1.id)


    get "/api/v1/transactions/find_all?result=#{result}"

    response_transactions = JSON.parse(response.body)
    transaction = response_transactions.first

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_2.id)
    expect(response_transactions.count).to eq(2)

  end
  it 'can find all transactions by credit_card_number' do
    credit_card_number = "4243783526189246"
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, credit_card_number: "9836451627482742", invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, credit_card_number: credit_card_number, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, credit_card_number: credit_card_number, invoice_id: invoice_1.id)


    get "/api/v1/transactions/find_all?credit_card_number=#{credit_card_number}"

    response_transactions = JSON.parse(response.body)
    transaction = response_transactions.first

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_2.id)
    expect(response_transactions.count).to eq(2)
  end
  it 'can find all transactions by credit_card_expiration_date' do
    credit_card_expiration_date = "4243783526189246"
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, credit_card_expiration_date: "9836451627482742", invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, credit_card_expiration_date: credit_card_expiration_date, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, credit_card_expiration_date: credit_card_expiration_date, invoice_id: invoice_1.id)


    get "/api/v1/transactions/find_all?credit_card_expiration_date=#{credit_card_expiration_date}"

    response_transactions = JSON.parse(response.body)
    transaction = response_transactions.first

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_2.id)
    expect(response_transactions.count).to eq(2)
  end
  it 'can find all transactions by created_at' do
    created_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, created_at: '2018-10-04 16:32:13 UTC', invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, created_at: created_at, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, created_at: created_at, invoice_id: invoice_1.id)


    get "/api/v1/transactions/find_all?created_at=#{created_at}"

    response_transactions = JSON.parse(response.body)
    transaction = response_transactions.first

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_2.id)
    expect(response_transactions.count).to eq(2)
  end
  it 'can find all transactions by updated_at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    transaction_1 = create(:transaction, updated_at: '2018-10-04 16:32:13 UTC', invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, updated_at: updated_at, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, updated_at: updated_at, invoice_id: invoice_1.id)


    get "/api/v1/transactions/find_all?updated_at=#{updated_at}"

    response_transactions = JSON.parse(response.body)
    transaction = response_transactions.first

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_2.id)
    expect(response_transactions.count).to eq(2)
  end
  it 'can find a random transaction' do
    merchant_1 = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    create_list(:transaction, 4, invoice_id: invoice_1.id)

    get "/api/v1/transactions/random"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.count).to eq(1)
  end

end
