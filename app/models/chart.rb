# == Schema Information
#
# Table name: charts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  password    :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  chart_songs :text
#

class Chart < ActiveRecord::Base
	has_many :votes
	belongs_to :user
	
	serialize :chart_songs, Hash
	
	def gather_votes
		@all_chart_votes = Vote.where(chart_id: self.id).collect{|vote| {vote.song_id => vote.score}}
		
		@each_song_vote = Hash.new(0)
		@all_chart_votes.each do |vote| 
			vote.each do |song_id, score|
				if score == -100
					@each_song_vote[song_id] = -1000000
				end
				@each_song_vote[song_id] += score unless @each_song_vote[song_id] == -1000000
			end
		end
		@chart_order = @each_song_vote.sort_by {|song_id, score| score}.reverse!
		@final_hash = Hash.new(0)
		@chart_order.each do |chart_song|
			if chart_song.last == -1000000
				@final_hash[chart_song.first] = "Do not play!"
			else
				@final_hash[chart_song.first] = chart_song.last
			end
		end
		self.chart_songs = @final_hash
		self.save
	end
end
