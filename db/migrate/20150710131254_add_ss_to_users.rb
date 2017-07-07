class AddSsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :ss_upload, :integer, default: 0
  	add_column :users, :ss_download, :integer, default: 0
  end
end
