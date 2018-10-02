class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.decimal :unit_price
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
