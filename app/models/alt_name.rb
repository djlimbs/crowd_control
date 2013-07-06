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

class AltName < ActiveRecord::Base
  belongs_to :diff_nameable, polymorphic: true
end
