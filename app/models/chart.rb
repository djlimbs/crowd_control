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
end
