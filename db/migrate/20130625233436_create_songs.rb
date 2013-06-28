class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :year
      t.references :artist, index: true

      t.timestamps
    end
  end
end
