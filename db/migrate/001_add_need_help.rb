class AddNeedHelp < ActiveRecord::Migration
  def self.up
    add_column :users, :needs_help, :boolean, :default => true
  end
  def self.down
    remove_column :users, :needs_help
  end
end