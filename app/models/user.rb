class User < ActiveRecord::Base
  attr_accessible :name
  has_many :focus_areas
  has_many :projects
  has_many :tickets
  has_many :procedures
end
