class CreateHasManyAndBelongsToRel < ActiveRecord::Migration
  def change
    create_table :artists_songs do |t|
    	t.belongs_to :artist
    	t.belongs_to :song
    end
  end
end
