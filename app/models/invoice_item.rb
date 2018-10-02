class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price

  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :invoices

  
end
