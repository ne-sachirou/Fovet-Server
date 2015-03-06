class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :count, null: false, default: 10
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.uuid :uuid, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
