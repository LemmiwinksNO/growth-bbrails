class ChangeFocusIdColumns < ActiveRecord::Migration
  def change
    rename_column :projects, :focus_id, :focus_area_id
    rename_column :procedures, :focus_id, :focus_area_id

  end

end
