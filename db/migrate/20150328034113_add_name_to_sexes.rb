class AddNameToSexes < ActiveRecord::Migration
  def change
    add_column :sexes, :name, :string
  end
end
