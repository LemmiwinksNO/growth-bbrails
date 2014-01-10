class Procedure < ActiveRecord::Base
  attr_accessible :focus_id, :notes, :title, :type
  belongs_to :focus
end
