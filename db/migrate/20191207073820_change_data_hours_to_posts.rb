class ChangeDataHoursToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :hours, :float
  end
end
