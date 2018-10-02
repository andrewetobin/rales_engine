require 'rails_helper'

describe Transaction, type: :model do
  describe "relationships" do
    it {should belong_to :invoice}
  end
  describe "validations" do
    it {should validate_presence_of :credit_card_number}
    it {should validate_presence_of :result}
  end
end
