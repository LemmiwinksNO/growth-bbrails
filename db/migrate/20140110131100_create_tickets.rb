class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :notes
      t.string :status
      t.string :priority
      t.integer :project_id

      t.timestamps
    end
  end
end
