require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page', type: :feature do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Jim Jimson")
    @discount1 = BulkDiscount.create!(name: "Discount 1", threshold: 5, discount: 5, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: "Discount 2", threshold: 10, discount: 10, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: "Discount 3", threshold: 30, discount: 30, merchant_id: @merchant1.id)
  end

  describe "I see all of my bulk discounts and their attributes" do
    it 'shows bulk discounts and their attributes' do
      visit merchant_bulk_discounts_path(@merchant1)
      
      within "#discount_#{@discount1.id}" do
        expect(page).to have_link(@discount1.name)
        expect(page).to have_content("Discount Percentage: #{@discount1.discount}")
        expect(page).to have_content("Number of items for discount: #{@discount1.threshold}")
        
        expect(page).to_not have_link(@discount2.name)
        expect(page).to_not have_content("Discount Percentage: #{@discount2.discount}")
        expect(page).to_not have_content("Number of items for discount: #{@discount2.threshold}")
        
        click_link("#{@discount1.name}")
        
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
      end
      
      visit merchant_bulk_discounts_path(@merchant1)
      within "#discount_#{@discount2.id}" do
        expect(page).to have_link(@discount2.name)
        expect(page).to have_content("Discount Percentage: #{@discount2.discount}")
        expect(page).to have_content("Number of items for discount: #{@discount2.threshold}")
        
        expect(page).to_not have_link(@discount3.name)
        expect(page).to_not have_content("Discount Percentage: #{@discount3.discount}")
        expect(page).to_not have_content("Number of items for discount: #{@discount3.threshold}")
        
        click_link("#{@discount2.name}")
        
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount2))
      end
    end
  end
  
  describe 'I see a link to create a new discount' do
    it 'clicks a link to create a new bulk discount' do
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_link("Create Discount")

      click_link("Create Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    end
  end
end