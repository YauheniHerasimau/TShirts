class AddColorToTShirts < ActiveRecord::Migration[8.0]
  def change
    add_column :t_shirts, :color, :string
  end
end
