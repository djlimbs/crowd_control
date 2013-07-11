# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Artist < ActiveRecord::Base
	has_and_belongs_to_many :songs
	has_many :alt_names, :as => :diff_nameable

	accepts_nested_attributes_for :songs, :alt_names, allow_destroy: true
	
	validates_presence_of :name
	
	def all_names
		return self.alt_names.collect{|alt_name| alt_name.alt_name }.push(self.name)
	end
	
	def self.find_or_create_artist(name)
		if @artist = Artist.where("lower(name) = ?", name.downcase).first
			return @artist
		elsif @alt_name = AltName.where("lower(alt_name) = ?", name.downcase).first
			return Artist.find_by(id: @alt_name.diff_nameable_id)
		else
			return Artist.create(name: name)
		end
	end
end