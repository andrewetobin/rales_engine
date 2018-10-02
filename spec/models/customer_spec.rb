require 'rails_helper'

describe Customer, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
  end
end
