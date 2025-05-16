class AddPaymentFieldsToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :stripe_id, :string
    add_column :orders, :payment_status, :string
    add_column :orders, :card_brand, :string
    add_column :orders, :card_last4, :string
  end
end
