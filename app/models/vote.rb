# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  voter_name :string(255)
#  song_id    :integer
#  chart_id   :integer
#  score      :float
#  created_at :datetime
#  updated_at :datetime
#

class Vote < ActiveRecord::Base
	belongs_to :song
	belongs_to :chart
	
	validates_uniqueness_of :voter_name, :scope => [:chart_id, :song_id]
end
