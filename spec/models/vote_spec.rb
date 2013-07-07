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

require 'spec_helper'

describe Vote do
  pending "add some examples to (or delete) #{__FILE__}"
end
