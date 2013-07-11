class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :display_name
      t.integer :year

      t.timestamps
    end
  end
end
