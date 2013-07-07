class RenameChartColumns < ActiveRecord::Migration
  def self.up
  	rename_column :charts, :chart_name, :name
  	rename_column :charts, :chart_password, :password
  end
  
  def self.down
  	rename_column :charts, :name, :chart_name
  	rename_column :charts, :password, :chart_password
  end
end
