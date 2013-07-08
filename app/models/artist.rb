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

	accepts_nested_attributes_for :songs, :alt_names
end
