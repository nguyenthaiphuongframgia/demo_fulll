class CreateSuggestProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :suggest_products do |t|
      t.string :name
      t.text :description
      t.string :image
      t.float :price
      t.boolean :is_confirm
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
