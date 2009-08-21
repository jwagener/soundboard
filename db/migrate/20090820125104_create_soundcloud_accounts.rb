class CreateSoundcloudAccounts < ActiveRecord::Migration
  def self.up
    create_table :soundcloud_accounts do |t|
      t.string :oauth_token
      t.string :oauth_token_secret
      t.string :username

      t.timestamps
    end
  end

  def self.down
    drop_table :soundcloud_accounts
  end
end
