# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  display_name :string(255)
#  year         :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Song do
  pending "add some examples to (or delete) #{__FILE__}"
end
