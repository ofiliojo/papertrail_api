class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :users
    create_table :users do |t|
      t.timestamps
      t.string     :full_name, null: false, default: ""
      t.string     :email, null: false, default: ""
      t.string     :password_digest, null: false, default: ""
      t.string     :token
      t.boolean    :admin, default: false
    end
    add_index :users, :token, unique: true
  end
end
