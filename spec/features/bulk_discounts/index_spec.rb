require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page', type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Jim Jimson")
    @discount1 = BulkDiscount.create!(name: "Discount 1", threshold: 5, discount: 5, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: "Discount 2", threshold: 10, discount: 10, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: "Discount 3", threshold: 30, discount: 30, merchant_id: @merchant1.id)
  end
end