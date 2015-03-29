class AddNameToMajors < ActiveRecord::Migration
  def change
    add_column :majors, :name, :string
  end
end
