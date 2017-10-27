class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, uniqueness: true
      t.string :phone_number, null: false, uniqueness: true
      t.string :full_name
      t.string :password, null: false
      t.string :key, null: false, uniqueness: true
      t.string :account_key, null: true, uniqueness: true
      t.string :metadata

      t.timestamps
    end
  end
end
