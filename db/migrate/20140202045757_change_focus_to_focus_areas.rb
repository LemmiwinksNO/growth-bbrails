class ChangeFocusToFocusAreas < ActiveRecord::Migration
  def change
    rename_table :focus, :focus_areas
  end
end
