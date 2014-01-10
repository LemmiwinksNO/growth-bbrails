class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.string :title
      t.string :type
      t.text :notes
      t.integer :focus_id

      t.timestamps
    end
  end
end
