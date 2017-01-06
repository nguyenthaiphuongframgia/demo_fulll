class RemoveValidateFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :validate, :string
  end
end
