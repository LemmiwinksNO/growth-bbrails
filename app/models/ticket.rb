class Ticket < ActiveRecord::Base
  attr_accessible :notes, :priority, :project_id, :status, :title
  belongs_to :project
end
