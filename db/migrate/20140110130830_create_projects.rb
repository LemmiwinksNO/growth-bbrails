class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :notes
      t.integer :focus_id

      t.timestamps
    end
  end
end
