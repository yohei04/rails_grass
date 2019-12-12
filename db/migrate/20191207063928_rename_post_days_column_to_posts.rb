class RenamePostDaysColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :post_days, :days
  end
end
