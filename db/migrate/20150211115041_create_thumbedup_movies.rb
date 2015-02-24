class CreateThumbedupMovies < ActiveRecord::Migration
  def change
    create_table :thumbedup_movies do |t|
      t.references :movie, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
