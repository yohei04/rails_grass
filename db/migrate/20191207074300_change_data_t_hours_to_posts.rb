class ChangeDataTHoursToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :t_hours, :float
  end
end
