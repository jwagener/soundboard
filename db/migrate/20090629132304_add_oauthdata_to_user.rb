class AddOauthdataToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :sc_user_id, :integer
    add_column :users, :sc_access_token, :string
    add_column :users, :sc_access_token_secret, :string
  end

  def self.down
    remove_column :users, :sc_access_token_secret
    remove_column :users, :sc_access_token
    remove_column :users, :sc_user_id
  end
end
