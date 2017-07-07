class AddEncryptedEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_email, :string, default: 0
  end
end
