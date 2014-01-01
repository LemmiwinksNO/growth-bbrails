class Notdo < ActiveRecord::Base
  # Makes attributes mass-assignable. Oppposite of attr_protected
  attr_accessible :title, :status, :project, :priority, :notes

  # Always validate :title
  validates_presence_of :title
  # Validate these unless its a new model.
  validates_presence_of :title, :status, :project, :unless => proc { new_record? }
end
