class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :voter_name
      t.integer :song_id
      t.integer :chart_song_id
      t.float :score

      t.timestamps
    end
  end
end
