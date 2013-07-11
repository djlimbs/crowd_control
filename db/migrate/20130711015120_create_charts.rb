class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
	  t.string :name
	  t.string :password
      t.integer :user_id

      t.timestamps
    end
  end
end
