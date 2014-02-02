class Procedure < ActiveRecord::Base
  attr_accessible :focus_area_id, :notes, :title, :category, :user_id
  belongs_to :focus_area
  belongs_to :user
end
