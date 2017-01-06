class AddStatusToSuggestProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :suggest_products, :status, :string, default: "Pending"
  end
end
