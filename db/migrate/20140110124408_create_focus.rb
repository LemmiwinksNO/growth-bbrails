class CreateFocus < ActiveRecord::Migration
  def change
    create_table :focus do |t|
      t.string :title
      t.text :notes

      t.timestamps
    end
  end
end
