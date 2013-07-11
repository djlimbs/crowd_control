# == Schema Information
#
# Table name: charts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  password   :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Chart < ActiveRecord::Base
	has_many :votes
	belongs_to :user
	
	def gather_votes
		@all_chart_votes = Vote.where(chart_id: self.id).collect{|vote| {vote.song_id => vote.score}}
		
		@each_song_vote = Hash.new(0)
		@all_chart_votes.each {|vote| vote.each {|song_id, score| @each_song_vote[song_id] += score}}
		@chart_order = @each_song_vote.sort_by {|song_id, score| score}.reverse!
		return @chart_order
		# just a ref to get ordered display names - @chart_order.each {|song_id, score| Song.find(song_id).display_name}
	end
end
