class CreatePedidos < ActiveRecord::Migration[8.1]
  def change
    create_table :pedidos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :total, precision:10, scale:2

      t.timestamps
    end
  end
end
