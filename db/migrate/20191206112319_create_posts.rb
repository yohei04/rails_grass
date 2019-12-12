class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.date :post_date
      t.integer :post_days
      t.time :posts_hours
      t.time :posts_t_hours
      t.text :content

      t.timestamps
    end
  end
end
