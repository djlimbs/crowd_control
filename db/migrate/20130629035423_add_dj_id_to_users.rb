class AddDjIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dj_id, :integer
  end
end
