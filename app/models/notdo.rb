class Notdo < ActiveRecord::Base
  attr_accessible :description, :project, :status, :title

  # Always validate :title
  validates_presence_of :title
  # Validate these unless its a new model.
  validates_presence_of :title, :status, :unless => proc { new_record? }
end
