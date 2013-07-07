# == Schema Information
#
# Table name: votes
#
#  id             :integer          not null, primary key
#  voter_name     :string(255)
#  artist_song_id :integer
#  chart_id       :integer
#  score          :float
#  created_at     :datetime
#  updated_at     :datetime
#

class Vote < ActiveRecord::Base
	belongs_to :artist_song
	belongs_to :chart
end
