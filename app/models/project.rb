class Project < ActiveRecord::Base
  attr_accessible :focus_area_id, :notes, :title, :user_id
  belongs_to :focus_area
  belongs_to :user
  has_many :tickets
end
