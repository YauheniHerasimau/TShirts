class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body, null: false
      t.boolean :read, default: false
      t.text :admin_reply

      t.timestamps
    end
  end
end
