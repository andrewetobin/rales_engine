require 'rails_helper'

describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end
  describe "validations"  do
    it {should validate_presence_of :name}
  end
end
