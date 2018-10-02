require 'csv'

namespace :import do
  desc "Import data from CSV file"

  task all: :environment do
    puts "Importing merchants..."
    CSV.foreach('db/csv/merchants.csv', headers: true, header_converters: :symbol) do |row|
      Merchant.create!(id: row[:id],
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at])
    end
    puts "Imported #{Merchant.count} merchants."

    puts "Importing customers..."
    CSV.foreach('db/csv/customers.csv', headers: true, header_converters: :symbol) do |row|
      Customer.create(id: row[:id],
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: row[:created_at],
        updated_at: row[:updated_at])
    end
    puts "Imported #{Customer.count} customers."

    puts "Importing invoices..."
    CSV.foreach('db/csv/invoices.csv', headers: true, header_converters: :symbol) do |row|
      Invoice.create(id: row[:id],
        customer_id: row[:customer_id],
        merchant_id: row[:merchant_id],
        status: row[:status],
        created_at: row[:created_at],
        updated_at: row[:updated_at])
    end
    puts "Imported #{Invoice.count} invoices."

    puts "Importing transactions..."
    CSV.foreach('db/csv/transactions.csv', headers: true, header_converters: :symbol) do |row|
      Transaction.create(id: row[:id],
        invoice_id: row[:invoice_id],
        credit_card_number: row[:credit_card_number],
        result: row[:result],
        created_at: row[:created_at],
        updated_at: row[:updated_at])
      end
    puts "Imported #{Transaction.count} transactions."

    puts "Importing items..."
    CSV.foreach('db/csv/items.csv', headers: true, header_converters: :symbol) do |row|
      Item.create(id: row[:id],
        name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price],
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at])
      end
    puts "Imported #{Item.count} items."

    puts "Importing invoice items..."
    CSV.foreach('db/csv/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(id: row[:id],
        item_id: row[:item_id],
        invoice_id: row[:invoice_id],
        quantity: row[:quantity],
        unit_price: row[:unit_price],
        created_at: row[:created_at],
        updated_at: row[:updated_at])
    end
    puts "Imported #{InvoiceItem.count} invoice items."
  end
end
