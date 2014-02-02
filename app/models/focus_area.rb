class FocusArea < ActiveRecord::Base
  attr_accessible :notes, :title, :user_id
  has_many :projects
  has_many :procedures
  belongs_to :user
end
