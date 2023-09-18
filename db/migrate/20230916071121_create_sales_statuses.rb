class CreateSalesStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :sales_statuses do |t|

      t.timestamps
    end
  end
end
