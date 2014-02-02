class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end

    add_column :focus, :user_id, :integer
    add_column :projects, :user_id, :integer
    add_column :procedures, :user_id, :integer
    add_column :tickets, :user_id, :integer

  end
end
