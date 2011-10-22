class RenameTextToBodyMarkdownInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :text, :body_markdown
  end
end
