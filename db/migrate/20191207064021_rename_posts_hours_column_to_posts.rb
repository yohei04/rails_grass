class RenamePostsHoursColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :posts_hours, :hours
  end
end
