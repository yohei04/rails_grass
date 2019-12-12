class RenamePostsTHoursColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :posts_t_hours, :t_hours
  end
end
