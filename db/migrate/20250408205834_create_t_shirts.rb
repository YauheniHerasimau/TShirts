class CreateTShirts < ActiveRecord::Migration[8.0]
  def change
    create_table :t_shirts do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :category, null: false, foreign_key: true
      t.string :size, null: false
      t.decimal :price, null: false
      t.string :image_url

      t.timestamps
    end
  end
end
