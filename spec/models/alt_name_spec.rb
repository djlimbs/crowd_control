# == Schema Information
#
# Table name: alt_names
#
#  id                 :integer          not null, primary key
#  alt_name           :string(255)
#  diff_nameable_type :string(255)
#  diff_nameable_id   :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe AltName do
  pending "add some examples to (or delete) #{__FILE__}"
end
