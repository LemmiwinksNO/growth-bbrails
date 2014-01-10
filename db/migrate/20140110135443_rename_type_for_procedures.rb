class RenameTypeForProcedures < ActiveRecord::Migration
  def change
    change_table :procedures do |t|
      t.rename :type, :category
    end
  end
end
