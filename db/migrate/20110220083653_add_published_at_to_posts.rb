class AddPublishedAtToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :published_at, :timestamp

    say_with_time "Setting published_at timestamp for all published posts" do
      Post.where(:published => true).each do |pst|
        pst.published_at = pst.created_at
        pst.save!
      end
    end
  end

  def self.down
    remove_column :posts, :published_at
  end
end
