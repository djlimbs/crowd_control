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
	validates_uniqueness_of :name
	default_scope order('name')
	
	def all_names
		return self.alt_names.collect{|alt_name| alt_name.alt_name }.push(self.name)
	end
	
	def self.find_or_create_artist(name)
		@name = String.new(name)
		@name = "Unknown Artist" if @name == ""
	
		if @artist = Artist.where("lower(name) = ?", @name.downcase).first
			return @artist
		elsif @alt_name = AltName.where("lower(alt_name) = ?", @name.downcase).first
			return Artist.find_by(id: @alt_name.diff_nameable_id)
		else
			@artist = Artist.create(name: @name)
			@artist.songs.create(title: "Anything by " + @artist.name, display_name: "Anything by " + @artist.name)
			return @artist
		end
	end
	
	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			@artist = Artist.find_or_create_artist(row.to_hash["Name"])
			if row.to_hash["AltNames"]
				row.to_hash["AltNames"].split("|").each do |alt_name|
					@artist.alt_names.find_or_create_by(alt_name: alt_name)
				end
			end
		end
	end
end