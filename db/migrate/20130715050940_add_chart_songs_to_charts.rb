class AddChartSongsToCharts < ActiveRecord::Migration
  def change
  	add_column :charts, :chart_songs, :text
  end
end
