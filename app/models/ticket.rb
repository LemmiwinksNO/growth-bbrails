class Ticket < ActiveRecord::Base
  attr_accessible :notes, :priority, :project_id, :status, :title, :user_id
  belongs_to :project
  belongs_to :user
end
