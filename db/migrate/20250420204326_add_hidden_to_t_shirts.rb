class AddHiddenToTShirts < ActiveRecord::Migration[8.0]
  def change
    add_column :t_shirts, :hidden, :boolean, default: false
  end
end
