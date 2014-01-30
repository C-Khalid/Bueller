class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :nickname
      t.string :email
      t.string :imageurl

      t.timestamps
    end
  end
end
