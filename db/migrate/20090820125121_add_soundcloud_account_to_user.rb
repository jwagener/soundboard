class AddSoundcloudAccountToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :soundcloud_account_id, :integer
  end

  def self.down
    remove_column :users, :soundcloud_account_id
  end
end
