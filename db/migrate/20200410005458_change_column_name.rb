class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :albums, :name, :artist
  end
end
