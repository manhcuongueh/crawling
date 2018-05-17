class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :title
      t.string :image_url
      t.integer :post_number
      t.integer :followers
      t.integer :following
      t.text :description

      t.timestamps
    end
  end
end
