class CreateOpinions < ActiveRecord::Migration[8.0]
  def change
    create_table :opinions do |t|
      t.references :t_shirt, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
