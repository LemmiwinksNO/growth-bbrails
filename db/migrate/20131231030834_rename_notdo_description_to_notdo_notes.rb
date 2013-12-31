class RenameNotdoDescriptionToNotdoNotes < ActiveRecord::Migration
  def up
    change_table :notdos do |t|
      t.rename :description, :notes
      t.index  :status
      t.index  :project
    end
  end

  def down
    change_table :notdos do |t|
      t.rename :notes, :description
      t.remove_index  :status
      t.remove_index  :project
    end
  end
end
