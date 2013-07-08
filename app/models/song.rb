# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  title        :string(255)
#  display_name :string(255)
#  year         :integer
#

class Song < ActiveRecord::Base
	has_and_belongs_to_many :artists
	has_many :alt_names, :as => :diff_nameable

	accepts_nested_attributes_for :artists, :alt_names
end
