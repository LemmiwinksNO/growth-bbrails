class Notdo < ActiveRecord::Base
  attr_accessible :description, :project, :status, :title
end
