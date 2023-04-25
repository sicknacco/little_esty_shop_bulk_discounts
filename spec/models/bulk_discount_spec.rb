require 'rails_helper'

describe BulkDiscount, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant)}
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :merchant_id }
    it { should validate_numericality_of :discount }
    it { should validate_numericality_of :threshold }
  end
end