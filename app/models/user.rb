class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :couples, :class_name => 'User', :foreign_key => :dj_id
  belongs_to :dj, :class_name => 'User'
  has_many :charts
  
  def dj?
  	dj_id.nil?
  end
  
  def couple?
  	!dj?
  end
end
