class Focus < ActiveRecord::Base
  attr_accessible :notes, :title
  has_many :projects
  has_many :procedures
end
