class CreateNotdos < ActiveRecord::Migration
  def change
    create_table :notdos do |t|
      t.string :title
      t.string :project
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
