class CreateInstagrams < ActiveRecord::Migration[5.2]
  def change
    create_table :instagrams do |t|
      t.string :username
      t.string :password
      t.string :insta_url

      t.timestamps
    end
  end
end
