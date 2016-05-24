class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :loginnum, :integer
  end
end
