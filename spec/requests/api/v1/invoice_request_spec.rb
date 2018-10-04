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

end
