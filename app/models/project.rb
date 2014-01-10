class Project < ActiveRecord::Base
  attr_accessible :focus_id, :notes, :title
  belongs_to :focus
  has_many :tickets
end
