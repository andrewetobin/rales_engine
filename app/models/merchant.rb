class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(limit = 5)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_total')
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
      .order('merchant_total DESC')
      .limit(limit)
  end

  def self.most_items(limit = 5)
    select('merchants.*, SUM(invoice_items.quantity) AS count')
      .joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
      .group(:id)
      .order('count DESC')
      .limit(limit)
  end


end
