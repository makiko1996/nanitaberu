class RenameTasteToTastes < ActiveRecord::Migration[5.2]
  def change
    rename_column :tastes, :taste, :name
  end
end
