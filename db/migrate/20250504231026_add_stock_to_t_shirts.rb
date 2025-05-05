class AddStockToTShirts < ActiveRecord::Migration[8.0]
  def change
    add_column :t_shirts, :stock, :integer, default: 0, null: false
  end
end
