class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.references :t_shirt, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
