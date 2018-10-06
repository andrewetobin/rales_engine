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
  it "can get one invoice by its ID" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer_id: customer.id, merchant_id: merchant.id).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoice["id"]).to eq(id)
  end
  it 'can find invoice by id' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end
  it 'can find invoice by status' do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice.status}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice.id)
  end
  it 'can find invoice by created at' do
    created_at = '2018-06-26 16:32:13 UTC'
    invoice_1 = create(:invoice, created_at: '2018-10-03 04:17:06 UTC')
    invoice_2 = create(:invoice, created_at: created_at)

    get "/api/v1/invoices/find?created_at=#{created_at}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice_2.id)
  end
  it 'can find invoice by updated at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    invoice_1 = create(:invoice, updated_at: '2018-10-03 04:17:06 UTC')
    invoice_2 = create(:invoice, updated_at: updated_at)

    get "/api/v1/invoices/find?updated_at=#{updated_at}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice_2.id)
  end
  it 'can find all invoices by id' do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice_1.id}"

    response_invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoice["id"]).to eq(invoice_1.id)
  end
  it 'can find all invoices by status' do
    invoice_1 = create(:invoice, status: 'success')
    invoice_2 = create(:invoice, status: 'declined')
    invoice_3 = create(:invoice, status: 'success')

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"

    response_invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoices.first["id"]).to eq(invoice_1.id)
    expect(response_invoices.count).to eq(2)
  end
  it 'can find all invoices created at' do
    created_at = '2018-06-26 16:32:13 UTC'
    invoice_1 = create(:invoice, created_at: '2018-10-03 04:17:06 UTC')
    invoice_2 = create(:invoice, created_at: created_at)
    invoice_3 = create(:invoice, created_at: created_at)

    get "/api/v1/invoices/find_all?created_at=#{created_at}"

    response_invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoices.first["id"]).to eq(invoice_2.id)
    expect(response_invoices.count).to eq(2)
  end
  it 'can find all invoices updated at' do
    updated_at = '2018-06-26 16:32:13 UTC'
    invoice_1 = create(:invoice, updated_at: '2018-10-03 04:17:06 UTC')
    invoice_2 = create(:invoice, updated_at: updated_at)
    invoice_3 = create(:invoice, updated_at: updated_at)

    get "/api/v1/invoices/find_all?updated_at=#{updated_at}"

    response_invoices = JSON.parse(response.body)
    expect(response).to be_successful
    expect(response_invoices.first["id"]).to eq(invoice_2.id)
    expect(response_invoices.count).to eq(2)
  end
  it 'can find a random invoice' do
    create_list(:invoice, 4)

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice.count).to eq(1)
  end
  it 'can get invoice transactions' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:transaction, 3, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end
  it 'can get invoice invoice_items' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    create_list(:invoice_item, 3, invoice_id: invoice.id, item_id: item.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(3)
  end
  it 'can get invoice items' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    item_3 = create(:item, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_3.id)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end
  it 'can get invoice customer' do
    merchant = create(:merchant)
    id = create(:customer).id
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: id)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(id)
  end
  it 'can get invoice merchant' do
    id = create(:merchant).id
    customer = create(:customer)
    invoice = create(:invoice, merchant_id: id, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(id)
  end
end
