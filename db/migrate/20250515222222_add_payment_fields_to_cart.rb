class AddPaymentFieldsToCart < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :stripe_id, :string
    add_column :carts, :payment_status, :string
    add_column :carts, :card_brand, :string
    add_column :carts, :card_last4, :string
  end
end
