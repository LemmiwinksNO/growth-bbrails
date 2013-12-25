class Crew < ActiveRecord::Base
  attr_accessible :age, :avatar, :name, :origin, :quote, :species, :title

  # Always validate :name
	validates_presence_of :name
  # Validate these unless its a new model.
	validates_presence_of :title, :origin, :age, :avatar, :species, :unless => proc { new_record? }
end
