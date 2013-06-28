class CreateAltNames < ActiveRecord::Migration
  def change
    create_table :alt_names do |t|
      t.string :alt_name
      t.string :diff_nameable_type
      t.references :diff_nameable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
