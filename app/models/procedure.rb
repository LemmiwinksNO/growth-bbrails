class Procedure < ActiveRecord::Base
  attr_accessible :focus_id, :notes, :title, :category
  belongs_to :focus
end
