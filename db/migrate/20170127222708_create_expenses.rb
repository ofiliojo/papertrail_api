class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.timestamps
      t.float      :amount, null: false, default: 0
      t.text       :description, null: false, default: ""
    end
  end
end
