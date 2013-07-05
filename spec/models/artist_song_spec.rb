# == Schema Information
#
# Table name: artist_songs
#
#  id           :integer          not null, primary key
#  artist_id    :integer
#  song_id      :integer
#  display_name :string(255)
#  year         :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe ArtistSong do
  pending "add some examples to (or delete) #{__FILE__}"
end
