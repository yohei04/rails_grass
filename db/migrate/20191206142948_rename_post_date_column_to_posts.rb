class RenamePostDateColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :post_date, :date
  end
end
