class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices


  def favorite_merchant
    merchants.select('merchants.*, COUNT(merchants.id) AS merchant_count')
      .group(:id)
      .order('merchant_count DESC')
      .first
  end
end
