class RemoveTitleFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :title
  end

  def self.down
    add_column :posts, :title, :string
  end
end
