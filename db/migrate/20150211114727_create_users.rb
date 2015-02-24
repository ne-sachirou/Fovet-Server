class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_hash, null: false

      t.timestamps
    end
  end
end
