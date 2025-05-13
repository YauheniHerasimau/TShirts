class FixReadColumnInMessages < ActiveRecord::Migration[8.0]
  def change
    change_column_default :messages, :read, from: nil, to: false
    Message.where(read: nil).update_all(read: false)
  end
end
