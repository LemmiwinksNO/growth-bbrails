class AddPriorityToNotdos < ActiveRecord::Migration
  def change
    add_column :notdos, :priority, :string
  end
end
