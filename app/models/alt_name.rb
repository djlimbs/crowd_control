class AltName < ActiveRecord::Base
  belongs_to :diff_nameable, polymorphic: true
end
